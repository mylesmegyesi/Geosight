class UsersController < ApplicationController
    before_filter :require_user, :except => [:new, :create]
    respond_to :html, :json, :xml
    
    def index
        @users = User.all
        respond_with(@users)
    end 

    def show
        @user = current_user
        respond_with(@user)
    end

    def new
        @user = User.new
    end

    def edit
        @user = current_user
        respond_with(@user)
    end

    def create
        @user = User.new(params[:user])
        @user.save
        respond_with(@user)
    end

    def update
        @user = current_user
        @user.update_attributes(params[:user])
        respond_with(@user)
    end

    def destroy
        @user = current_user
        @user.destroy
        redirect_to root_url #go to the root_url
    end
end
