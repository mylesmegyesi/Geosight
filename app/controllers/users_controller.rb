class UsersController < ApplicationController
    before_filter :require_user, :except => [:new, :create]
    respond_to :html, :json
    
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
        if @user.update_attributes(params[:user])
            flash[:notice] = "Settings successfully updated"
        else
            flash[:error] = "There was a problem updating your Settings"
        end
        respond_with(@user)
    end

    def destroy
        @user = current_user
        if @user.destroy
            flash[:notice] = "Account successfully deleted"
        else
            flash[:error] = "There was a problem deleting your account"
        end
        respond_with(@user) do |format|
            format.html { redirect_to home_path }
        end
    end
end
