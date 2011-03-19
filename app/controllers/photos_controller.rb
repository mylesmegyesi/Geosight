class PhotosController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json
    
    def index
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            redirect_to unassigned_photos_path
            return
        end
        @photos = @sight.photos            
    end

    def show
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            redirect_to not_found_path
            return
        end
        
        if @photo.sight.nil?
            redirect_to edit_photo_path(@photo)
            return
        end
        
        @tag = Tag.new
        @comment = Comment.new
        
        respond_with(@photo)
    end
    
    def new
        @photo = Photo.new
    end
    
    def edit
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            redirect_to not_found_path
            return
        end
    end
    
    def create 
        @photo = Photo.new(params[:photo])
        if @photo.save
            flash[:notice] = "Photo successfully created"
        else
            flash[:error] = "There was a problem creating your Photo"
        end
        respond_with(@photo)
    end
    
    def update
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            redirect_to not_found_path
            return
        end
        
        if params[:photo][:existing_sight_id] == "0"
            @sight = Sight.new
            @sight.name = params[:photo][:name]
            @sight.radius = params[:photo][:radius]
            @sight.latitude = @photo.latitude
            @sight.longitude = @photo.longitude
            @sight.user_id = current_user.id
            
            if not @sight.save
                @sight.errors.each do |attr, msg|
                    @photo.errors.add(attr, msg)
                end
                respond_with(@photo)
                return
            end
        else
            @sight = Sight.find_by_id(params[:photo][:existing_sight_id])
            if @sight.nil?
                redirect_to not_found_path
                return
            end
        end
        
        @photo.update_attribute(:sight_id, @sight.id)
        respond_with(@photo)
    end

    def destroy
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            redirect_to not_found_path
            return
        end
        if @photo.destroy
            flash[:notice] = "Photo successfully deleted"
        else
            flash[:error] = "There was a problem deleting your Photo"
        end
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            respond_with(@photo)
        else
            respond_with(@sight)
        end
    end
    
    def unassigned
        @photos = Photo.where(:user_id => current_user.id, :sight_id => nil)
    end
end
