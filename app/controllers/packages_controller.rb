class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    @last_charge = Charge.where(user_id: current_user.id).last
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    @user = current_user

    Stripe.api_key = ENV['stripe_api_key']

    plan = Stripe::Plan.create(
      :name => @package.title,
      :id => @package.title.parameterize,
      :interval_count => @package.subscription_interval_count,
      :interval => @package.subscription_interval.downcase,
      :currency => "aud",
      :amount => (@package.price * 100).ceil,
    )

    @package.update_attributes(stripe_subscription_id: plan.id)

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update

    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy

    Stripe.api_key = ENV['stripe_api_key']
    plan = Stripe::Plan.retrieve(@package.title.parameterize)
    plan.delete

    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def subscribe_user
    @user = current_user
    @package = Package.find(params[:package_id])
    @customer_exists = params[:customer] 

    Stripe.api_key = ENV['stripe_api_key']

    # if user selected new card - create customer in stripe else add customer to package.
    if @customer_exists == false
      token = params[:stripeToken]
      # Create a Customer:
      customer = Stripe::Customer.create(
        :email => current_user.email,
        :source => token,
      )
      @user.update_attributes(stripe_customer_id: customer.id )
    end

    #add customer to package is subscription based - create in stripe
    if @package.subscription == true
        
      Stripe::Subscription.create(
        :customer => @user.stripe_customer_id,
        :items => [
          {
            :plan => @package.title.parameterize,
          },
        ],
      )

    else
      # raise a charge in stripe
      charge = Stripe::Charge.create(
        :amount => (@package.price * 100).ceil,
        :currency => "aud",
        :description => @package.title,
        :customer => @user.stripe_customer_id,
      )

    end

    if @package.subscription == true
      @newcharge = Charge.new(
        user_id: current_user.id
      )
      @newcharge.save!
    else
      @newcharge = Charge.new(
        user_id: current_user.id,
        stripe_id: charge.id,
        amount: charge.amount / 100,
        card_brand: charge.source.brand,
        card_last4: charge.source.last4,
        card_exp_month: charge.source.exp_month,
        card_exp_year: charge.source.exp_year,
        status: "pending",
        failure_code: charge.failure_code,
        failure_message: charge.failure_message,
        packages_payment: true
      )
      @newcharge.save!
    end


    @up = UserPackage.new(user_id: @user.id, package_id: @package.id)
    @up.save

    #find points and update them
    @points = Point.where(user_id: current_user.id).first

    if @points.blank?
      #create a record
      Point.new(user_id: current_user.id, number_of_points: @package.price.ceil)
    else
      #find current points
      @updated_points = @points.number_of_points + @package.price.ceil
      #update record
      @points.update_attributes(user_id: current_user.id, number_of_points: @updated_points)
    end
    
    redirect_to package_subscription_confirmation_path(@package)
  end

  def subscription_confirmation

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:title, :description, :price, :subscription, :subscription_interval_count, :subscription_interval, :stripe_subscription_id, :number_of_points)
    end
end
