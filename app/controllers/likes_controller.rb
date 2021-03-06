class LikesController < ApplicationController
  include MainConcern

  before_action :set_like, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ submitlike ]
  before_action :set_user, only: %i[ submitlike ]

  def submitlike
    @comment = Comment.find(params[:id])
    @restaurant = Restaurant.find(@comment.restaurant_id)
    if (params[:commit]=='Like')
      @dislike = Like.find_by(user:@user,comment:@comment,like_type:false)
      if (@dislike != nil)
        @dislike.destroy
      end
      Like.create(user:@user,comment:@comment,like_type:true).save
      redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have liked comment."
    elsif (params[:commit]=='Unlike')
      @like = Like.find_by(user:@user,comment:@comment,like_type:true)
      if (@like != nil)
        @like.destroy
      end
      redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have unliked comment."
    elsif (params[:commit]=='Dislike')
      @like = Like.find_by(user:@user,comment:@comment,like_type:true)
      if (@like != nil)
        @like.destroy
      end
      Like.create(user:@user,comment:@comment,like_type:false).save
      redirect_to showrestaurant_path(@restaurant.restaurant_name), alert: "You have disliked comment."
    elsif (params[:commit]=='Undislike')
      @dislike = Like.find_by(user:@user,comment:@comment,like_type:false)
      if (@dislike != nil)
        @dislike.destroy
      end
      redirect_to showrestaurant_path(@restaurant.restaurant_name), alert: "You have undisliked comment."
    else
      redirect_to showrestaurant_path(Restaurant.find(@comment.restaurant_id).restaurant_name)
    end
  end

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:user_id, :comment_id, :like_type)
    end
end
