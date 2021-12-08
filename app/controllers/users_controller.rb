class UsersController < ApplicationController
  include MainConcern

  before_action :find_user, only: %i[ show edit update destroy ]
  before_action :check_login, only: %i[ profile submitprofile deleteuser ]
  before_action :set_user, only: %i[ profile submitprofile deleteuser ]

  def profile
  end

  def submitprofile
    if(params[:commit]=='Delete')
      @user.destroy
      session[:id] = nil
      redirect_to login_path, alert: "Successfully delete account."
    elsif(params[:commit]=='Save')
      @new_name = params[:user][:display_name]
      if (@new_name == "")
        redirect_to home_path
      else
        @old_name = @user.display_name
        if @user.update(display_name:@new_name)
          redirect_to home_path, notice: "You have changed display name from #{@old_name} to #{@user.display_name}."
        else
          redirect_to profile_path, alert: @user.errors.full_messages.to_sentence
        end
      end
    else
      redirect_to home_path
    end
  end

  def delete
    @user = User.find(params[:user_id])
    if @user
      session[:id] = nil
      @user.destroy
      redirect_to login_path, alert: "Successfully delete account."
    else
      redirect_to home_path, alert: "Cannot delete this account."
    end
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :register, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
    end
end
