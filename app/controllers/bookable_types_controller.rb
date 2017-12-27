class BookableTypesController < ApplicationController
  before_action :set_bookable_type, only: [:show, :edit, :update, :destroy]

  # GET /bookable_types
  # GET /bookable_types.json
  def index
    @bookable_types = BookableType.all
  end

  # GET /bookable_types/1
  # GET /bookable_types/1.json
  def show
  end

  # GET /bookable_types/new
  def new
    @bookable_type = BookableType.new
  end

  # GET /bookable_types/1/edit
  def edit
  end

  # POST /bookable_types
  # POST /bookable_types.json
  def create
    @bookable_type = BookableType.new(bookable_type_params)

    respond_to do |format|
      if @bookable_type.save
        format.html { redirect_to @bookable_type, notice: 'Bookable type was successfully created.' }
        format.json { render :show, status: :created, location: @bookable_type }
      else
        format.html { render :new }
        format.json { render json: @bookable_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookable_types/1
  # PATCH/PUT /bookable_types/1.json
  def update
    respond_to do |format|
      if @bookable_type.update(bookable_type_params)
        format.html { redirect_to @bookable_type, notice: 'Bookable type was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookable_type }
      else
        format.html { render :edit }
        format.json { render json: @bookable_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookable_types/1
  # DELETE /bookable_types/1.json
  def destroy
    @bookable_type.destroy
    respond_to do |format|
      format.html { redirect_to bookable_types_url, notice: 'Bookable type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookable_type
      @bookable_type = BookableType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookable_type_params
      params.require(:bookable_type).permit(:title, :description, :featured_image)
    end
end
