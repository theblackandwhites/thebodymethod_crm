class BookablesController < ApplicationController
  before_action :set_bookable, only: [:show, :edit, :update, :destroy]
  require 'date'

  # GET /bookables
  # GET /bookables.json
  def index
    
    @search = Bookable.where("start_time >= ?", Time.now).search(params[:q])
    @bookables = @search.result
    @most_expensive = Bookable.order('price DESC').first
    @today_date = Date.today
   

  end

  # GET /bookables/1
  # GET /bookables/1.json
  def show

    @user = current_user || User.new
    @participants = Participant.where(bookable_id: @bookable.id).all
    @attending = @bookable.attendee_count.to_i - @participants.count.to_i
    @walkin = Walkin.new
    @last_charge = Charge.where(user_id: @user.id).last
    @currently_attending = Participant.where(bookable_id: @bookable.id).where(user_id: @user.id).last
    @points = Point.where(user_id: @user.id).last
    @qualifications = Qualification.where(instructor_id: @bookable.instructor_id).all
    
  end

  # GET /bookables/new
  def new
    @bookable = Bookable.new
  end

  # GET /bookables/1/edit
  def edit
  end

  # POST /bookables
  # POST /bookables.json
  def create
    @bookable = Bookable.new(bookable_params)
    @bookable.calendar_bookables

    respond_to do |format|
      if @bookable.save
        format.html { redirect_to @bookable, notice: 'Bookable was successfully created.' }
        format.json { render :show, status: :created, location: @bookable }
      else
        format.html { render :new }
        format.json { render json: @bookable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookables/1
  # PATCH/PUT /bookables/1.json
  def update
    respond_to do |format|
      if @bookable.update(bookable_params)
        format.html { redirect_to @bookable, notice: 'Bookable was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookable }
      else
        format.html { render :edit }
        format.json { render json: @bookable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookables/1
  # DELETE /bookables/1.json
  def destroy
    @bookable.destroy
    respond_to do |format|
      format.html { redirect_to bookables_url, notice: 'Bookable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookable
      @bookable = Bookable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookable_params
      params.require(:bookable).permit(:date_start, :time_start, :time_start_unit, :time_finish, :time_finish_unit, :bookable_type_id, :location_id, :instructor_id, :price, :pay_cash, :pay_online, :pay_points, :attendee_count, :reconciled, :recurring, :start_time)
    end
end
