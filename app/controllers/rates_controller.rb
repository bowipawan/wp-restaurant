class RatesController < ApplicationController
  include MainConcern

  before_action :set_rate, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ makerate submitrate ]
  before_action :set_user, only: %i[ makerate submitrate ]

  def makerate
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    @rate = Rate.find_by(user_id:@user.id)
    if (@rate == nil)
      @rate = Rate.new
    end
  end

  def submitrate
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    if not ["0","1","2","3","4","5"].include?(params[:rate][:rate_score])
      redirect_to makerate_path(@restaurant.restaurant_name), alert: "Rate score must be integer between 0-5."
    else
      if(params[:commit]=='Rate')
        @rate = Rate.find_by(user_id:@user.id)
        if (@rate == nil)
          @rate = Rate.new(rate_params)
          @rate.restaurant_id = @restaurant.id
          @rate.user_id = @user.id
          redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have rated #{@restaurant.restaurant_name} with score #{@rate.rate_score}."
        else
          @old_rate = @rate.rate_score
          @rate.update(rate_params)
          redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have changed rate for #{@restaurant.restaurant_name} from score #{@old_rate} to #{@rate.rate_score}."
        end
        @rate.save
      else
        redirect_to showrestaurant_path(@restaurant.restaurant_name)
      end
    end
  end

  # GET /rates or /rates.json
  def index
    @rates = Rate.all
  end

  # GET /rates/1 or /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates or /rates.json
  def create
    @rate = Rate.new(rate_params)

    respond_to do |format|
      if @rate.save
        format.html { redirect_to @rate, notice: "Rate was successfully created." }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1 or /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to @rate, notice: "Rate was successfully updated." }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1 or /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: "Rate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.require(:rate).permit(:user_id, :restaurant_id, :rate_score)
    end
end
