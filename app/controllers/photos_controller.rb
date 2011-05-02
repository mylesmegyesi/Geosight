class PhotosController < ApplicationController
    before_filter :require_user, :except => [:show]
    respond_to :html, :json, :js
    
    def index
        @photos = Photo.where(:user_id => current_user.id)
        respond_with(@photos)
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
		@rating = Rating.new
        
        respond_with(@photo)
    end
	
	def edit
		@photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            flash[:error] = "Photo not found"
            redirect_to not_found_path
            return
        end
	end
    
    def new
        @photo = Photo.new
    end
    
    def create
        @photo = Photo.new(params[:photo])
        if not @photo.save
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
        
        if not @photo.destroy
            flash[:error] = "There was a problem deleting your Photo"
        end
        
        respond_with(@photo)
    end
end
