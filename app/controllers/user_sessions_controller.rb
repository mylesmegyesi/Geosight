class UserSessionsController < ApplicationController
    before_filter :require_user, :only => :destroy
    respond_to :html, :json, :xml
    
    def new
        if current_user
            redirect_to user_path(current_user)
        else
            @user_session = UserSession.new
        end
    end

    def create
        @user_session = UserSession.new(params[:user_session])
        if @user_session.save
            redirect_to user_path(current_user)
        else
            render :action => :new
        end
    end

    def destroy
        current_user_session.destroy
        redirect_to root_url
    end
end