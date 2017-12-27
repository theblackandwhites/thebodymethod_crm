class ChargeController < ApplicationController
  def my_charges
    @bookable = params[:bookable]
    if @bookable.present?
  	  @charges = Charge.where(bookable_id: @bookable).where(user_id: current_user.id).all
    else
      @charges = Charge.where(user_id: current_user.id).all 
    end

    @search = Bookable.search(params[:q])
    @bookables = @search.result
    
  end

  def create_customer
  	@user = current_user
  	@bookable = Bookable.find(params[:bookable_id])

  	Stripe.api_key = ENV['stripe_api_key']
  	token = params[:stripeToken]

  	# Create a Customer:
  	customer = Stripe::Customer.create(
  	  :email => current_user.email,
  	  :source => token,
  	)

  	@user.update_attributes(stripe_customer_id: customer.id )

  	redirect_to bookable_create_charge_path(@bookable)
  end

  def create_charge
    Stripe.api_key = ENV['stripe_api_key']
  	@bookable = Bookable.find(params[:bookable_id])
  	# Charge the Customer instead of the card:
  	charge = Stripe::Charge.create(
  	  :amount => (@bookable.price * 100).floor + 100,
  	  :currency => "aud",
  	  :customer => current_user.stripe_customer_id,
  	)

  	@mycharge = Charge.new(user_id: current_user.id, 
  				bookable_id: @bookable.id,
          bookable_type_id: @bookable.bookable_type,
  				stripe_id: charge.id,
  				amount: charge.amount / 100,
  				card_brand: charge.source.brand,
  				card_last4: charge.source.last4,
  				card_exp_month: charge.source.exp_month,
  				card_exp_year: charge.source.exp_year,
  				status: "pending",
  				failure_code: charge.failure_code,
  				failure_message: charge.failure_message,
          online_payment: true
  				)
  	@mycharge.save


  	redirect_to bookable_confirm_booking_path(@bookable, :pm => "online", :mycharge => @mycharge.id)

  end

  # if paid in points transact here
  def create_customer_points
    @user = current_user
    @bookable = Bookable.find(params[:bookable_id])

    Stripe.api_key = ENV['stripe_api_key']
    token = params[:stripeToken]

    # Create a Customer:
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source => token,
    )

    @user.update_attributes(stripe_customer_id: customer.id )

    redirect_to bookable_create_charge_points_path(@bookable)

  end

  def create_charge_points
    @payment_type = params[:pm]
    @bookable = Bookable.find(params[:bookable_id])
    @wallet = Point.where(user_id: current_user.id).last 

    @points = @wallet.number_of_points

    @updated_number_of_points = @bookable.price.ceil - @wallet.number_of_points
    @left_to_pay = @bookable.price - @points

    Stripe.api_key = ENV['stripe_api_key']
    # Charge the Customer instead of the card:
    charge = Stripe::Charge.create(
      :amount => (@left_to_pay * 100).floor,
      :currency => "aud",
      :customer => current_user.stripe_customer_id,
    )

    @wallet.update_attributes(number_of_points: 0)
    @mycharge = Charge.new(user_id: current_user.id,
                        bookable_id: @bookable.id,
                        bookable_type_id: @bookable.bookable_type,
                        amount: @left_to_pay,
                        status: "pending",
                        points: true,
                        points_paid_with: @points,
                        left_to_pay: @left_to_pay,
                        left_to_pay_method: "Online",
                        points_online_payment: true
                        )
    @mycharge.save

    redirect_to bookable_confirm_booking_path(@bookable, :pm => "points-and-online", :mycharge => @mycharge.id)

  end

  def edit_charge
    @charge = Charge.find(params[:key])
  end

  def update_charge
    @charge = Charge.find(charge_params[:id])
    @updated_charge = @charge.update_attributes(charge_params)

    redirect_to bookable_participants_path(:key => @charge.bookable_id)
  end

   private

    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_params
      params.require(:charge).permit(:amount, :id)
    end


end
