class MainController < ApplicationController
  include MainConcern
  
  before_action :check_login, only: %i[ home ]
  before_action :set_user, only: %i[ home ]

  def main
    if session[:user_id] == nil
      redirect_to login_path
    else
      redirect_to home_path
    end
  end

  def login
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to home_path
    else
      @user = User.new
      @user.email = params[:email]
    end
  end

  def submitlogin
    session[:user_id] = nil
    @email = params[:user][:email]
    @password = params[:user][:password]
    @user = User.find_by(email:@email)
    if (@user && @user.authenticate(@password))
      redirect_to home_path, notice: "Successfully login."
      session[:user_id] = @user.id
    else
      redirect_to login_path(email:@email), alert: "Wrong username or password."
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: "Successfully logout."
  end

  def register
    session[:user_id] = nil
    @user = User.new
    @user.email = params[:email]
    @user.display_name = params[:display_name]
  end

  def submitregister
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path(email:@user.email), notice: "Successfully registered."
    else
      redirect_to register_path(email:@user.email,display_name:@user.display_name), alert: @user.errors.full_messages
    end
  end

  def home
    @appointments = @user.appointments.sort_by{ |obj| obj.time_start }
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
    end

end
