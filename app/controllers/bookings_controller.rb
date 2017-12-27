class BookingsController < ApplicationController

  def my_bookings
  	@bookings= Participant.includes(:bookable).where(user_id: current_user.id).all
  end

  def checkin
  	@bookable = Bookable.find(params[:bookable_id])
  	@participants = Participant.where(bookable_id: params[:bookable_id]).all
  end

  def post_checkin
  	@bookable = Bookable.find(params[:bookable_id])
  	@participant = Participant.find(params[:key])
  	@participant.update_attributes(checked_in: true)
  	redirect_to bookable_checkin_path(@bookable)
  end	

   def close_booking_screen
  	@bookable = Bookable.find(params[:bookable_id])
  	@participants = Participant.where(bookable_id: params[:bookable_id]).where(checked_in: true).all
  	@noshows = Participant.where(bookable_id: params[:bookable_id]).where(checked_in: false).all
  end

  def close_participant
  	@method = params[:method]
  	@paid = params[:paid]
  	@bookable = Bookable.find(params[:bookable_id])
  	@participant = Participant.find(params[:key])
    @debt = Debt.find(params[:debt])

    if params[:debt].present?
      @price = @bookable.price - @debt.amount
    else
      @price = @bookable.price
    end
  	#close participant
  	@participant.update_attributes(closed: true)

  	#if cash - create charge with total @bookable.price
  	if @method == "cash" || @method == "walkin"
  		@charge = Charge.new(
        user_id: @participant.user_id,
        bookable_id: @bookable.id,
        bookable_type_id: @bookable.bookable_type,
        amount: @price,
        status: "successful",
        cash_payment: true
        )
  		@charge.save
  	#update charge raised by points
  	elsif @method == "points-and-cash"
  		@charge = Charge.find(@participant.charge_id)
  		@charge.update_attributes(
        status: "successful",
        left_to_pay: 0,
        amount: @bookable.price
        )
  	end

    @participant.update_attributes(charge_id: @charge.id)
		
  	redirect_to bookable_close_booking_screen_path(@bookable)
  end	

  def close_booking

  end


end
