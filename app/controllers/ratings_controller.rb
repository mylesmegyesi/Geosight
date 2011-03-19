class RatingsController < ApplicationController
    before_filter :require_user
    respond_to :html, :json

    def create
        @rating = Rating.new(params[:rating])
        if @rating.save
            flash[:notice] = "Rating successfully created"
        else
            flash[:error] = "There was a problem creating your Rating"
        end
        respond_with_parent(@rating, @rating.photo, @rating.sight)
    end

    def update
        @rating = Rating.find_by_id(params[:id])
        if @rating.nil?
            redirect_to not_found_path
            return
        end
        if @rating.update_attributes(params[:rating])
            flash[:notice] = "Rating successfully updated"
        else
            flash[:error] = "There was a problem updating your Rating"
        end
        respond_with_parent(@rating, @rating.photo, @rating.sights)
    end

    def destroy        
        @rating = Rating.find_by_id(params[:id])
        if @rating.nil?
            redirect_to not_found_path
            return
        end
        @sight = @rating.sight
        @photo = @rating.photo
        if @rating.destroy
            flash[:notice] = "Rating successfully deleted"
        else
            flash[:error] = "There was a problem delesting your Rating"
        end
        respond_with_parent(@rating, @photo, @sight)
    end
end
