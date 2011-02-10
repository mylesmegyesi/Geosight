class TempPhotosController < ApplicationController
    respond_to :html, :json, :xml
    
    def index
        @photos = TempPhoto.all
    end

    def show
        @photo = TempPhoto.find(params[:id])
    end

    def new
        @photo = TempPhoto.new
    end

    def edit
        @photo = TempPhoto.find(params[:id])
    end

    def create
        photo = params[:photo]
        photo[:user_id] = current_user
        photo[:sight_id] = params[:sight_id]
        @photo = TempPhoto.new(params[:photo])
        @photo.save
        respond_with(@photo)
    end

    def update
        photo = params[:photo]
        photo[:user_id] = current_user
        photo[:sight_id] = params[:sight_id]
        @photo = TempPhoto.find(params[:id])
        @photo.update_attributes(photo)
        respond_with(@photo)
    end

    def destroy
        @photo = TempPhoto.find(params[:id])
        @photo.destroy
        respond_with(@photo)
    end
end
