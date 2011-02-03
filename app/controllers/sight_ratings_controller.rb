class SightRatingsController < ApplicationController
    respond_to :html, :json, :xml
    
    def index
        @sight = Sight.find(params[:sight_id])
        @sight_ratings = @sight.sight_ratings
        respond_with(@sight_ratings) do |format|
            format.html { respond_with([@sight, @sight_ratings]) }
        end
    end

    def show
        @sight = Sight.find(params[:sight_id])
        @sight_rating = SightRating.find(params[:id])
        respond_with(@sight_rating) do |format|
            format.html { respond_with([@sight, @sight_rating]) }
        end
    end

    def new
        @sight = Sight.find(params[:sight_id])
        @sight_rating = SightRating.new
        respond_with(@sight_rating) do |format|
            format.html { respond_with([@sight, @sight_rating]) }
        end
    end

    def edit
        @sight = Sight.find(params[:sight_id])
        @sight_rating = SightRating.find(params[:id])
    end

    def create
        params[:sight_rating][:user_id] = current_user
        params[:sight_rating][:sight_id] = params[:sight_id]
        @sight = Sight.find(params[:sight_id])
        @sight_rating = SightRating.new(params[:sight_rating])
        @sight_rating.save
        respond_with(@sight_rating) do |format|
            format.html { respond_with([@sight, @sight_rating]) }
        end
    end

    def update
        @sight = Sight.find(params[:sight_id])
        @sight_rating = SightRating.find(params[:id])
        @sight_rating.update_attributes(params[:sight_rating])
        respond_with(@sight_rating) do |format|
            format.html { respond_with([@sight, @sight_rating]) }
        end
    end

    def destroy
        @sight = Sight.find(params[:sight_id])
        @sight_rating = SightRating.find(params[:id])
        @sight_rating.destroy
        respond_with(@sight_rating) do |format|
            format.html { respond_with([@sight, @sight_rating]) }
        end
    end
end
