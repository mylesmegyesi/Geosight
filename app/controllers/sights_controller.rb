class SightsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json

    def index
        @sights = Sight.all
        respond_with(@sights)        
    end

    def show
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
		@tag = Tag.new
		@comment = Comment.new
        respond_with(@sight)
    end

    def new
        @sight = Sight.new
        respond_with(@sight)
    end

    def edit
        @sight = Sight.find_by_ids(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
    end

    def create
        @sight = Sight.new(params[:sight])
        if @sight.save
            # Add photos to Sight
            @sight.photos.concat(Photo.find_photos(@sight.latitude, @sight.longitude, @sight.radius))
        else
            flash[:error] = "There was a problem saving your Sight"
        end
        respond_with(@sight)
    end

    def update
        @sight = Sight.find_by_ids(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
        if not @sight.update_attributes(params[:sight])
            flash[:error] = "There was a problem updating your Sight"
        end
        respond_with(@sight)
    end

    def destroy
        @sight = Sight.find(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
        @sight.photos.each do |photo|
            photo.update_attribute(:sight_id, nil)
        end
        @sight.destroy
        respond_with(@sight)
    end
end
