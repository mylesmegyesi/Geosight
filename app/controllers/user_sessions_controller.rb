class UserSessionsController < ApplicationController
    before_filter :require_user, :only => :destroy
    respond_to :html, :json, :xml
    
    def new
        if current_user
            respond_with(current_user_session) do |format|
                format.html { redirect_to user_path(current_user) }
            end
        else
            @user_session = UserSession.new
        end
    end
    
    def show
        if current_user
            redirect_to user_path(current_user)
        else
            redirect_to new_user_session_path
        end
    end

    def create
        @user_session = UserSession.new(params[:user_session])
        @user_session.save
        respond_with(@user_session)
    end

    def destroy
        current_user_session.destroy
        redirect_to root_url
    end
end