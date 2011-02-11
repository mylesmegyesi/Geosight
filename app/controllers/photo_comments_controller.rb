class PhotoCommentsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json, :xml
    
    def index
        @sight = Sight.find(params[:sight_id])
        @photo = @sight.photos.find(params[:photo_id])
        @photo_comments = @photo.photo_comments
        respond_with(@photo_comments) do |format|
            format.html { respond_with([@sight, @photo, @photo_comments]) }
        end
    end

    def show
        @sight = Sight.find(params[:sight_id])
        @photo = @sight.photos.find(params[:photo_id])
        @photo_comment = @photo.photo_comments.find(params[:id])
        respond_with(@photo_comment) do |format|
            format.html { respond_with([@sight, @photo, @photo_comment]) }
        end
    end

    def new
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_comment = PhotoComment.new
        respond_with(@photo_comment) do |format|
            format.html { respond_with([@sight, @photo, @photo_comment]) }
        end
    end

    def edit
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_comment = PhotoComment.find(params[:id])
    end

    def create
        params[:photo_comment][:user_id] = current_user
        params[:photo_comment][:photo_id] = params[:photo_id]
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_comment = PhotoComment.new(params[:photo_comment])
        @photo_comment.save
        respond_with(@photo_comment) do |format|
            format.html { respond_with([@sight, @photo, @photo_comment]) }
        end
    end

    def update
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_comment = PhotoComment.find(params[:id])
        @photo_comment.update_attributes(params[:photo_comment])
        respond_with(@photo_comment) do |format|
            format.html { respond_with([@sight, @photo, @photo_comment]) }
        end
    end

    def destroy
        @sight = Sight.find(params[:sight_id])
        @photo = Photo.find(params[:photo_id])
        @photo_comment = PhotoComment.find(params[:id])
        @photo_comment.destroy
        respond_with(@photo_comment) do |format|
            format.html { respond_with([@sight, @photo, @photo_comment]) }
        end
    end
end
