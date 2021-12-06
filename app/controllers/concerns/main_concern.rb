module MainConcern
  extend ActiveSupport::Concern
    def check_login
      if !session[:user_id]
        redirect_to login_path, alert: "Please login."
      end
    end

    def set_user
      @user = User.find(session[:user_id])
    end
end