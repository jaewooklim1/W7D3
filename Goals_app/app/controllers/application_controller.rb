class ApplicationController < ActionController::Base

    helper_method :current_user, :login!

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)

        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        !!@current_user 
    end

    def logged_out!
        if logged_in?
            @current_user.reset_session_token!
        end

        session[:session_token] = nil
        @current_user = nil
    end

end
