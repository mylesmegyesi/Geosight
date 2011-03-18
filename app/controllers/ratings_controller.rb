class RatingsController < ApplicationController
    before_filter :require_user
    respond_to :html, :json

    def create
        @rating = Rating.new(params[:rating])
        @rating.save
        respond_with_parent(@rating, @rating.photo, @rating.sight)
    end

    def update
        @rating = Rating.find_by_id(params[:id])
        if @rating.nil?
            not_found("", "Rating does not exist", home_path)
            return
        end
        @rating.update_attributes(params[:rating])
        @rating.save
        respond_with_parent(@rating, @rating.photo, @rating.sights)
    end

    def destroy        
        @rating = Rating.find_by_id(params[:id])
        if @rating.nil?
            not_found("", "Rating does not exist", home_path)
            return
        end
        @sight = @rating.sight
        @photo = @rating.photo
        @rating.destroy
        respond_with_parent(@rating, @photo, @sight)
    end
end
