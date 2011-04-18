class PhotosController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json
    
    def index
        @user = current_user
        respond_with(@user)
    end

    def show
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            flash[:error] = "Photo not found"
            redirect_to not_found_path
            return
        end
        
        @tag = Tag.new
        @comment = Comment.new
        
        respond_with(@photo)
    end
    
    def new
        @photo = Photo.new
    end
    
    def create 
        if not params[:photo].nil?
            params[:photo][:user_id] = current_user.id
        end
        @photo = Photo.new(params[:photo])
        if @photo.save
            # Add sights to photo
            @photo.sights.concat(Sight.find_sights(@photo.latitude, @photo.longitude))
        else
            puts @photo.errors.to_s
            flash[:error] = "There was a problem saving your Photo"
        end
        respond_with(@photo)
    end

    def destroy
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            flash[:error] = "Photo not found"
            redirect_to not_found_path
            return
        end
        
        @photo.sights.clear
        
        if not @photo.destroy
            flash[:error] = "There was a problem deleting your Photo"
        end
        
        respond_with(@photo)
    end
end
