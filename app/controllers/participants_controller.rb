class ParticipantsController < ApplicationController
  require 'securerandom'

  def confirm_booking
  	@bookable = Bookable.find(params[:bookable_id])
  	@payment_type = params[:pm]
    @charge = Charge.find_by_id(params[:mycharge])

  	if @payment_type == "cash"
  		participant = Participant.new(bookable_id: @bookable.id,
                                    user_id: current_user.id,
                                    checked_in: false,
                                    payment_method: @payment_type,
                                    payment_status: "Cash required",
                                    closed: false,
                                    reconciled: false
                                    )

  	elsif @payment_type == "online"
  		participant = Participant.new(bookable_id: @bookable.id,
                                    user_id: current_user.id,
                                    charge_id: params[:mycharge],
                                    checked_in: false,
                                    payment_method: @payment_type,
                                    payment_status: "Payment made online",
                                    closed: false,
                                    reconciled: false
                                    )
  	
    elsif @payment_type == "points"
      participant = Participant.new(bookable_id: @bookable.id,
                                    user_id: current_user.id,
                                    charge_id: params[:mycharge],
                                    checked_in: false,
                                    payment_method: @payment_type,
                                    payment_status: "Paid in full with points",
                                    closed: false,
                                    reconciled: false
                                    )

    elsif @payment_type == "points-and-online"
      participant = Participant.new(bookable_id: @bookable.id,
                                    user_id: current_user.id,
                                    charge_id: params[:mycharge],
                                    checked_in: false,
                                    payment_method: @payment_type,
                                    payment_status: "Paid in full with points and online payment",
                                    closed: false,
                                    reconciled: false
                                    )

    elsif @payment_type == "points-and-cash"
      participant = Participant.new(bookable_id: @bookable.id,
                                    user_id: current_user.id,
                                    charge_id: params[:mycharge],
                                    checked_in: false,
                                    payment_method: @payment_type,
                                    payment_status: "Paid some points $#{@charge.left_to_pay} to be paid in cash",
                                    closed: false,
                                    reconciled: false
                                    )
      elsif @payment_type == "walkin"
        @password = SecureRandom.random_number(36**12).to_s(36).rjust(6, "0")
        @walkin = Walkin.find(params[:key])
        u = User.new(email: @walkin.email, password: @password)
        u.save

        @walkin.update_attributes(user_id: u.id)

        participant = Participant.new(bookable_id: @bookable.id,
                                      user_id: u.id,
                                      charge_id: params[:mycharge],
                                      checked_in: false,
                                      payment_method: @payment_type,
                                      payment_status: "Walk in, paid cash",
                                      closed: false,
                                      reconciled: false
                                      )

        #send email to new user with @password

    end

    participant.save!

  	redirect_to  bookable_booking_confirmation_path(@bookable)
  end

  def booking_confirmation

    @charge = Charge.where(user_id: current_user.id).where(bookable_id: params[:bookable_id]).last
    @bookable = Bookable.find(params[:bookable_id])
    @participant = Participant.where(user_id: current_user.id).last

    if @charge.present? && @charge.failure_code?
      @charge.update_attributes(status: "failed")
      @participant.update_attributes(payment_method: "cash")
    end
  end

  def add_to_waitlist
    w = WaitingList.new(user_id: current_user.id, bookable_id: params[:bookable_id])
    w.save
    redirect_to bookable_waiting_list_confirmation_path(params[:bookable_id])
  end

  def waiting_list_confirmation
    @bookable = Bookable.find(params[:bookable_id])
  end

  def cancel_booking
    @bookable = Bookable.find(params[:bookable_id])
    @user = current_user
    @booking = Participant.where(bookable_id: @bookable.id).where(id: params[:part]).where(user_id: current_user).first
    @charge = Charge.where(user_id: current_user.id).where(bookable_id: @bookable.id).last
    @booking.destroy

    ###### EMAIL EXISTING USERS ON WAITING LIST #######

    # If charged online via stripe - refund the money. Will take 5-10 business days.
    # Only refund if bookable is in the future - Integrate refund policy for SaS client - they choose how many days to allow cancellation.
    
    if @charge.present? && @booking.checked_in == false
      Stripe.api_key = ENV["stripe_api_key"]

      #If charge exists change status to cancelled
      @charge.update_attributes(status: "refunded")

      Stripe::Refund.create(
        :charge => @charge.stripe_id
      )
    end

    #if refund_policy_days.present?
    #end
    if @booking.checked_in == false
      redirect_to my_bookings_path, notice: 'You have successfully cancelled your booking.'
    else
      redirect_to my_bookings_path, notice: 'You are trying to request a refund after you have already checked in. Please contact the instructor.'
    end

  end

  def walkin_booking
    @bookable = Bookable.find(params[:bookable_id])
    @walkin = Walkin.new(walkin_params)
    @walkin.save

    @walkin.update_attributes(become_regular: false)

    redirect_to bookable_confirm_booking_path(@bookable, :pm => "walkin", :key => @walkin.id)
  end

  def bookable_participants
    @participants = Participant.where(bookable_id: params[:key]).all
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def walkin_params
    params.require(:walkin).permit(:first_name, :last_name, :phone, :email)
  end

end
