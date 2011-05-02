class RatingsController < ApplicationController
    before_filter :require_user
    respond_to :html, :json, :js

    def create
        if params[:rating].nil?
            redirect_to not_found_path
            return
        end
        
        @rating = Rating.new(params[:rating])
        if @rating.save
            flash[:notice] = "Rating successfully created"
        else
            flash[:error] = "There was a problem creating your Rating"
        end
        respond_with(@rating) do |format|
            format.html { respond_with(@rating.parent) }
			format.js
        end
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
        respond_with(@rating) do |format|
            format.html { respond_with(@rating.parent) }
			format.js
        end
    end

    def destroy        
        @rating = Rating.find_by_id(params[:id])
        if @rating.nil?
            redirect_to not_found_path
            return
        end
        
        if @rating.destroy
            flash[:notice] = "Rating successfully deleted"
        else
            flash[:error] = "There was a problem delesting your Rating"
        end
        respond_with(@rating) do |format|
            format.html { respond_with(@rating.parent) }
			format.js
        end
    end
end
