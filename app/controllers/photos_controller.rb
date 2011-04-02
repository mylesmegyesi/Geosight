class PhotosController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json
    
    def index
        @sight = Sight.find_by_id(params[:sight_id])
        if @sight.nil?
            @photos = current_user.photos
        else
            @photos = @sight.photos
        end
        respond_with(@photos) do |format|
            format.json {
                @photos = @photos.collect do |photo|
                    add_urls_to_photo(photo)
                    photo
                end
                respond_with(@photos)
            }
        end
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
        
        respond_with(@photo) do |format|
            format.json {
                add_urls_to_photo(@photo)
                respond_with(@photo)
            }
        end
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
        
        if not @photo.sight.nil?
            redirect_to photo_path(@photo)
        end
    end
    
    def create 
        @photo = Photo.new(params[:photo])
        if @photo.save
            flash[:notice] = "Photo successfully created"
        else
            flash[:error] = "There was a problem creating your Photo"
        end
        respond_with(@photo) do |format|
            format.json {
                add_urls_to_photo(@photo)
                respond_with(@photo)
            }
        end
    end
    
    def update
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            redirect_to not_found_path
            return
        end
        if not @photo.sight.nil?
            flash[:error] = "Photo already assigned to a Sight"
            redirect_to photo_path(@photo)
        end
        
        if params[:photo].nil?
            redirect_to not_found_path
            return
        end
        if params[:photo][:existing_sight_id].nil?
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
        
        respond_with(@photo) do |format|
            format.json {
                add_urls_to_photo(@photo)
                respond_with(@photo)
            }
        end
    end

    def destroy
        @photo = Photo.find_by_id(params[:id])
        if @photo.nil?
            redirect_to not_found_path
            return
        end
        @sight = @photo.sight
        if @photo.destroy
            flash[:notice] = "Photo successfully deleted"
        else
            flash[:error] = "There was a problem deleting your Photo"
        end
        
        sight_destroyed = false
        if not @sight.nil?
            if @sight.photos.empty?
                sight_destroyed = true
                @sight.destroy
            end
        end
        
        respond_with(@photo) do |format|
            format.html {
                if (not Sight.find_by_id(params[:sight_id]).nil?) && (not sight_destroyed)
                    respond_with(@sight)
                elsif sight_destroyed
                    redirect_to sights_path
                else
                    respond_with(@photo)
                end
            }
        end
    end
    
    def unassigned
        @photos = Photo.where(:user_id => current_user.id, :sight_id => nil)
        respond_with(@photos) do |format|
            format.json {
                @photos = @photos.collect do |photo|
                    add_urls_to_photo(photo)
                    photo
                end
                respond_with(@photos)
            }
        end
    end
end
