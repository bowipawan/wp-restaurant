class CommentsController < ApplicationController
  include MainConcern

  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ makecomment submitcomment delete ]
  before_action :set_user, only: %i[ makecomment submitcomment delete ]

  def makecomment
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    @comment = Comment.find_by(user_id:@user.id)
    if (@comment == nil)
      @comment = Comment.new
    end
  end

  def submitcomment
    @restaurant = Restaurant.find_by(restaurant_name:params[:restaurant_name])
    if(params[:commit]=='Comment')
      @comment = Comment.find_by(user_id:@user.id)
      if (@comment == nil)
        @comment = Comment.new(comment_params)
        @comment.restaurant_id = @restaurant.id
        @comment.user_id = @user.id
        redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have commented #{@restaurant.restaurant_name}."
      else
        @comment.update(comment_params)
        redirect_to showrestaurant_path(@restaurant.restaurant_name), notice: "You have edited comment for #{@restaurant.restaurant_name}."
      end
      @comment.save
    else
      redirect_to showrestaurant_path(@restaurant.restaurant_name)
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    @restaurant_id = @comment.restaurant_id
    if (@comment == nil)
      redirect_to showrestaurantid_path(@restaurant_id)
    else
      @comment.destroy
      redirect_to showrestaurantid_path(@restaurant_id), alert: "You have deleted comment."
    end
  end

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :restaurant_id, :msg)
    end
end
