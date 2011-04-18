class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    protect_from_forgery # See ActionController::RequestForgeryProtection for details
    helper_method :current_session, :current_user, :require_user, :store_location
    
    private
    def current_session
        return @current_session if defined?(@current_session)
        @current_session = UserSession.find
    end

    def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_session && current_session.user
    end

    def require_user
        unless current_user
            store_location
            redirect_to login_path
            return false
        end
    end

    def store_location
        session[:return_to] = request.fullpath
    end

end