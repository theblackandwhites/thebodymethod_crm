class DebtsController < ApplicationController
  before_action :set_debt, only: [:show, :edit, :update, :destroy]

  # GET /debts
  # GET /debts.json
  def index
    @debts = Debt.all
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @bookable = Bookable.where(id: params[:bookable]).first
    @participant = Participant.where(id: params[:participant]).first
    
    if @participant.present?
      if @participant.payment_method == "points-and-cash"
        @amount = @participant.charge.left_to_pay
      else
        @amount = @bookable.price
      end
    end

    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts
  # POST /debts.json
  def create
    @debt = Debt.new(debt_params)
    @debt.save

    @bookable = Bookable.find(@debt.bookable_id)
    @user = Bookable.find(@debt.user_id)
    @participant = Participant.find(@debt.participant_id)

    #Close participant
    redirect_to bookable_close_participant_path(@booking, :paid => true, :method => @participant.payment_method, :bookable_id => @bookable.id, :key => @participant.id, :debt => @debt.id )
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to @debt, notice: 'Debt was successfully updated.' }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  #Pay Debt
  def pay_debt
    @debt = Debt.find(params[:debt_id])
    Stripe.api_key = ENV['stripe_api_key']

    token = params[:stripeToken]

    charge = Stripe::Charge.create(
      :amount => (@debt.amount * 100 + 100).ceil,
      :currency => "aud",
      :description => "Debt Paid REF:#{@debt.id}",
      :source => token,
    )

    @mycharge = Charge.new(
          user_id: current_user, 
          bookable_id: @debt.bookable.id,
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
          debt_payment: true
          )
    @mycharge.save

    if @mycharge.failure_code == nil
      @debt.destroy
    end

    redirect_to profile_path(@debt.user_id)
  end 

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to debts_url, notice: 'Debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:user_id, :bookable_id, :participant_id, :amount)
    end
end
