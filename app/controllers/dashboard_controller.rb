class DashboardController < ApplicationController
  def client_aquisition

  if params[:search].present?
   @search = params[:search].to_date
  elsif params[:search].blank?
   @search = Time.now - 7.days
  end

  if params[:search_to].present?
   @search_to = params[:search_to].to_date + 1.day
  elsif params[:search_to].blank?
   @search_to = Time.now
  end
  
      #Bookings
      @bookings = Participant.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count
      @booking_cash =Participant.where(payment_method: "cash").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count
      @booking_points =Participant.where(payment_method: "points").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count
      @booking_online =Participant.where(payment_method: "online").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count
      @booking_points_online =Participant.where(payment_method: "points-and-online").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count
      @booking_points_cash =Participant.where(payment_method: "points-and-cash").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count

      #Sales
      @charges = Charge.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all
      @sales = @charges.sum(:amount)
      #Successful sales
      @successful_sales = @charges.where(status: "successful").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all
      @successful_sales_sum = @successful_sales.sum(:amount)
      #Pending sales
      @pending_sales = @charges.where(status: "pending").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all
      @pending_sales_sum = @successful_sales.sum(:amount)

      #Refunded Sales
      @refunded_sales = @charges.where(status: "refunded").where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all  
      @refunded_sales_sum = @refunded_sales.sum(:amount)

      #Clients
      @clients = User.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all.count
      @newclients = Participant.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).where(user_id: Participant.select(:user_id).group(:user_id).having("count(*) = 1").select(:user_id)).count


      #Bookable_types - How much revenue by booking type
      @charges_bookable_type = Charge.group('bookable_type_id').where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).all
      @charges_bookable_type_sum = @charges_bookable_type.sum(:amount)

      #Sales By Day
      @charges_by_day = Charge.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).group_by_day(:created_at)
      @charges_by_day_sum = @charges_by_day.sum(:amount)

      #Sales By Month
      @charges_by_month = Charge.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).group_by_month(:created_at)
      @charges_by_month_sum = @charges_by_month.sum(:amount)


      #Sales By Year
      @charges_by_year = Charge.where(["created_at >= ? AND created_at <= ? ",@search, @search_to ]).group_by_year(:created_at)
      @charges_by_year_sum = @charges_by_year.sum(:amount)

  end

  def analytics
  end

  def schedual
    @bookables = Bookable.where("start_time > ?", Date.today).order('created_at DESC').all
    @bookable_days = @bookables.group_by_day(:start_time).all
  end
end
