class EnquriesController < ApplicationController
  before_action :set_enqury, only: [:show, :edit, :update, :destroy]

  # GET /enquries
  # GET /enquries.json
  def index
    @enquries = Enqury.all
  end

  # GET /enquries/1
  # GET /enquries/1.json
  def show
  end

  # GET /enquries/new
  def new
    @enqury = Enqury.new
  end

  # GET /enquries/1/edit
  def edit
  end

  # POST /enquries
  # POST /enquries.json
  def create
    @enqury = Enqury.new(enqury_params)

    respond_to do |format|
      if @enqury.save
        format.html { redirect_to @enqury, notice: 'Enqury was successfully created.' }
        format.json { render :show, status: :created, location: @enqury }
      else
        format.html { render :new }
        format.json { render json: @enqury.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enquries/1
  # PATCH/PUT /enquries/1.json
  def update
    respond_to do |format|
      if @enqury.update(enqury_params)
        format.html { redirect_to @enqury, notice: 'Enqury was successfully updated.' }
        format.json { render :show, status: :ok, location: @enqury }
      else
        format.html { render :edit }
        format.json { render json: @enqury.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enquries/1
  # DELETE /enquries/1.json
  def destroy
    @enqury.destroy
    respond_to do |format|
      format.html { redirect_to enquries_url, notice: 'Enqury was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enqury
      @enqury = Enqury.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enqury_params
      params.require(:enqury).permit(:full_name, :email, :phone, :message)
    end
end
