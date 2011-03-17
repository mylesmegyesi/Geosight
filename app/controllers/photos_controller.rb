class PhotosController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json
    
    def index
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            not_found("Sight doesn't exist", home_path)
        end
        @photos = @sight.photos
        respond_with([@sight, @photos])
    end

    def show
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            not_found("Sight doesn't exist", home_path)
        end
        
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            not_found("Photo doesn't exist", sight_path(@sight))
        end
        
        @photos = @sight.photos
        
        @comment = Comment.new
        @comments = @photo.comments
        
        @tag = Tag.new
        @tags = @photo.photo_tags
        
        respond_with([@sight, @photo])
    end

    def destroy
        @sight= Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            not_found("Sight doesn't exist", home_path)
        end
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            not_found("Photo doesn't exist", sight_path(@sight))
        end
        @photo.destroy
        respond_with([@sight, @photo])
    end
    
    def move_to_unassigned
    end
end
