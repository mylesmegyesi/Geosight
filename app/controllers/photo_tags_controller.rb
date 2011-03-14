class PhotoTagsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json, :xml
    
    def index
        @sight = Sight.find(params[:sight_id])
        @photo = @sight.photos.find(params[:photo_id])
        @photo_tags = @photo.photo_tags
        respond_with(@photo_tags) do |format|
            format.html { respond_with([@sight, @photo, @photo_tags]) }
        end
    end

    def show
        @sight = Sight.find(params[:sight_id])
        @photo = @sight.photos.find(params[:photo_id])
        @photo_tag = @photo.photo_tags.find(params[:id])
        respond_with(@photo_tag) do |format|
            format.html { respond_with([@sight, @photo, @photo_tag]) }
        end
    end

    def new
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_tag = PhotoTag.new
        respond_with(@photo_tag) do |format|
            format.html { respond_with([@sight, @photo, @photo_tag]) }
        end
    end

    def edit
        @sight = Sight.find(params[:sight_id])
        @photo = @sight.photos.find(params[:photo_id])
        @photo_tag = @photo.photo_tags.find(params[:id])
    end

    def create
        params[:photo_tag][:user_id] = current_user.id
        params[:photo_tag][:photo_id] = params[:photo_id]
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_tag = PhotoTag.new(params[:photo_tag])
        @photo_tag.save
        respond_with(@photo_tag) do |format|
            format.html { respond_with([@sight, @photo]) }
        end
    end

    def update
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_tag = PhotoTag.find(params[:id])
        @photo_tag.update_attributes(params[:photo_tag])
        respond_with(@photo_tag) do |format|
            format.html { respond_with([@sight, @photo, @photo_tag]) }
        end
    end

    def destroy
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_tag = PhotoTag.find(params[:id])
        @photo_tag.destroy
        respond_with(@photo_tag) do |format|
            format.html { respond_with([@sight, @photo, @photo_tag]) }
        end
    end
end
