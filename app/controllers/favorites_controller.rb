class FavoritesController < ApplicationController
  include MainConcern

  before_action :set_favorite, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ listfavorite submitfavorite delete ]
  before_action :set_user, only: %i[ listfavorite submitfavorite delete ]

  def listfavorite
    puts Favorite.where(user_id:@user.id).pluck('restaurant_id')
    @favorites = Restaurant.where(:id => Favorite.where(user_id:@user.id).pluck('restaurant_id')).order("restaurant_name")
  end

  def submitfavorite
    @restaurant = Restaurant.find(params[:id])
    if(params[:commit]=='Favorite')
      Favorite.create(user:@user,restaurant:@restaurant).save
      redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have favorite #{@restaurant.restaurant_name}."
    else
      @favorite = Favorite.find_by(user:@user,restaurant:@restaurant)
      if (@favorite == nil)
        redirect_to showrestaurant_path(@restaurant.restaurant_name)
      else
        @favorite.destroy
        redirect_to showrestaurant_path(@restaurant.restaurant_name), alert: "You have unfavorite #{@restaurant.restaurant_name}."
      end
    end
  end

  def delete
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    @favorite = Favorite.find_by(user_id:@user.id,restaurant_id:@restaurant.id)
    if (@favorite)
      @favorite.destroy
      respond_to do |format|
        format.html { redirect_to listfavorite_url, notice: "You have unfavorite #{@restaurant.restaurant_name}." }
        format.json { head :no_content }
      end
    end
  end

  # GET /favorites or /favorites.json
  def index
    @favorites = Favorite.all
  end

  # GET /favorites/1 or /favorites/1.json
  def show
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites or /favorites.json
  def create
    @favorite = Favorite.new(favorite_params)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @favorite, notice: "Favorite was successfully created." }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorites/1 or /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: "Favorite was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_url, notice: "Favorite was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :restaurant_id)
    end
end
