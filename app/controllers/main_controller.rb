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
    end
  end

  def logging_in
    session[:user_id] = nil
    @user = User.find_by(email: params[:user][:email])
    puts params[:user][:email]
    puts params[:user][:password]
    puts @user.authenticate(params[:user][:password])
    if (@user && @user.authenticate(params[:user][:password]))
      redirect_to home_path, notice: "Successfully login."
      session[:user_id] = @user.id
    else
      redirect_to login_path, alert: "Wrong username or password."
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: "Successfully logout."
  end

  def register
    session[:user_id] = nil
    @user = User.new
  end

  def home
    @appointments = @user.appointments
  end

end
