class UserSessionsController < ApplicationController
    before_filter :require_user, :only => :destroy
    respond_to :html, :json
    
    def new
        if current_user
            respond_with(current_session) do |format|
                format.html { redirect_to user_path(current_user.id) }
            end
        else
            @user_session = UserSession.new
        end
    end

    def create
        @user_session = UserSession.new(params[:user_session])
        if @user_session.save
            respond_with(@user_session) do |format|
                format.html { redirect_to user_path(@user_session.user) }
            end
        else
            respond_with(@user_session) do |format|
                format.json { render :json => @user_session.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        current_session.destroy
        redirect_to root_url
    end
end
