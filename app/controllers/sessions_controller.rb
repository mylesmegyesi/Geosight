class UserSessionsController < ApplicationController
    before_filter :require_user, :only => :destroy
    respond_to :html, :json
    
    def new
        if current_user
            respond_with(current_session) do |format|
                format.html { redirect_to user_path(current_user.id) }
            end
        else
            @user_session = Session.new
        end
    end

    def create
        @session = Session.new(params[:user_session])
        if @session.save
            respond_with(@session) do |format|
                format.html { redirect_to user_path(@session.user) }
            end
        else
            respond_to do |format|
                format.html { redirect_to login_path }
                format.json { render :json => @session.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        current_session.destroy
        redirect_to root_url
    end
end
