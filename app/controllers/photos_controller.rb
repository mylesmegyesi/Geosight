class PhotosController < ApplicationController
    respond_to :html, :json, :xml
    
    def index
        @sight = Sight.find(params[:sight_id])
        @photos = @sight.photos
        respond_with([@sight, @photo])
    end

    def show
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:id])
        respond_with([@sight, @photo])
    end

    def new
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.new
        respond_with([@sight, @photo])
    end

    def edit
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:id])
    end

    def create
        photo = params[:photo]
        photo[:user_id] = current_user
        photo[:sight_id] = params[:sight_id]
        @photo = Photo.new(params[:photo])
        @sight = Sight.find(@photo.sight_id)
        @photo.save
        respond_with([@sight, @photo])
    end

    def update
        photo = params[:photo]
        photo[:user_id] = current_user
        photo[:sight_id] = params[:sight_id]
        @photo = Photo.find(params[:id])
        @sight = Sight.find(@photo.sight_id)
        @photo.update_attributes(photo)
        respond_with([@sight, @photo])
    end

    def destroy
        @photo = Photo.find(params[:id])
        @sight = Sight.find(@photo.sight_id)
        @photo.destroy
        respond_with([@sight, @photo])
    end
end
