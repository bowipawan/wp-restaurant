class RestaurantsController < ApplicationController
  include MainConcern

  before_action :set_restaurant, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ listrestaurant showrestaurant ]
  before_action :set_user, only: %i[ listrestaurant showrestaurant ]

  def listrestaurant
    @restaurants = Restaurant.all.sort_by{ |obj| obj.restaurant_name }
  end

  def showrestaurant
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    @comments = Comment.where(restaurant_id:@restaurant.id).sort_by{ |obj| obj.updated_at }.reverse!
    @like = Like.new
    @favorite = Favorite.new
    @rate = @restaurant.rates.average(:rate_score)
  end

  def showrestaurantid
    redirect_to showrestaurant_path(Restaurant.find(params[:restaurant_id]).restaurant_name)
  end

  # GET /restaurants or /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:restaurant_name)
    end
end
