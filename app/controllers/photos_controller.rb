class PhotosController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json, :xml
    
    def index
        @sight = Sight.find(params[:sight_id])
        @photos = @sight.photos
        respond_with(@photos) do |format|
            format.html { respond_with([@sight, @photos]) }
        end
    end

    def show
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:id])
        @photo_comment = PhotoComment.new
        @photo_comments = @photo.photo_comments
        respond_with(@photo) do |format|
            format.html { respond_with([@sight, @photo]) }
        end
    end

    def destroy
        @photo = Photo.find(params[:id])
        @sight = Sight.find(@photo.sight_id)
        @photo.destroy
        respond_with(@photo) do |format|
            format.html { respond_with([@sight, @photo]) }
        end
    end
end
