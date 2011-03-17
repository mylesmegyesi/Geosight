class PhotosController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json
    
    def index
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            sight_not_found
        end
        @photos = @sight.photos
        respond_with(@photos)
    end

    def show
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            sight_not_found
        end
        
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            photo_not_found
        end
        
        @photos = @sight.photos
        
        @comment = Comment.new
        @comments = @photo.comments
        
        @tag = Tag.new
        @tags = @photo.photo_tags
        
        respond_with(@photo)
    end

    def destroy
        @photo = Photo.find(params[:id])
        @sight = Sight.find(@photo.sight_id)
        @photo.destroy
        respond_with(@photo)
    end
    
    def move_to_unassigned
    end
end
