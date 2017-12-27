class PointsController < ApplicationController


  def new_points
    @points = Point.new
  end

  def create_points
    @wallet = Point.where(user_id: point_params[:user_id]).last

    if @wallet.blank?
      @points = Point.new(point_params)
      @points.save
    else
      @updated_number_of_points = @wallet.number_of_points.to_i + point_params[:number_of_points].to_i
      @wallet.update_attributes(number_of_points: @updated_number_of_points)
    end

    redirect_to new_points_path, notice: 'Points were added.'
  end

  def remove_points
    @points = Point.new
  end

  def delete_points
    @wallet = Point.where(user_id: point_params[:user_id]).last

    if @wallet.blank?
      redirect_to remove_points_path, notice: 'Sorry this user has not got any points.'
    else
      if @wallet.number_of_points.to_i >= point_params[:number_of_points].to_i
        @updated_number_of_points = @wallet.number_of_points.to_i - point_params[:number_of_points].to_i
        @wallet.update_attributes(number_of_points: @updated_number_of_points)
        redirect_to remove_points_path, notice: 'Points were deleted.'
      else
        redirect_to remove_points_path, notice: "Sorry you this user only has #{@wallet.number_of_points.to_i} number of points."
      end
    end
  end

  def pay_with_points
    @payment_type = params[:pm]
    @bookable = Bookable.find(params[:bookable_id])
    @wallet = Point.where(user_id: current_user.id).last 

    @points = @wallet.number_of_points

    if @wallet.number_of_points > @bookable.price.ceil
      @updated_number_of_points = @points - @bookable.price.ceil
      @left_to_pay = 0
    else
      @updated_number_of_points = @bookable.price.ceil - @wallet.number_of_points
      @left_to_pay = @bookable.price - @points
    end

    if @left_to_pay == 0
      # DON'T CHARGE WITH STRIPE - JUST UPDATE POINTS AND CREATE POINTS CHARGE
      @wallet.update_attributes(number_of_points: @updated_number_of_points)
        charge = Charge.new(user_id: current_user.id,
                            bookable_id: @bookable.id,
                            bookable_type_id: @bookable.bookable_type,
                            amount: @bookable.price,
                            status: "successful",
                            points: true,
                            points_paid_with: @bookable.price.ceil,
                            left_to_pay: 0
                            )
        charge.save
        redirect_to  bookable_confirm_booking_path(@bookable, :mycharge => charge.id, :pm => "points")
    else

      if @payment_type == "points-and-cash"
        @wallet.update_attributes(number_of_points: 0)
        charge = Charge.new(user_id: current_user.id,
                            bookable_id: @bookable.id,
                            bookable_type_id: @bookable.bookable_type,
                            amount: @points, #currently charging full amount - needs to charge just the points section
                            status: "pending-partial-payment",
                            points: true,
                            points_paid_with: @points,
                            left_to_pay: @left_to_pay,
                            left_to_pay_method: "Cash",
                            points_cash_payment: true
                            )
        charge.save
        redirect_to  bookable_confirm_booking_path(@bookable, :mycharge => charge.id, :pm => "points-and-cash" )

      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def point_params
    params.require(:point).permit(:number_of_points, :user_id)
  end

end
