class SightCommentsController < ApplicationController
    respond_to :html, :json, :xml
    
    def index
        @sight = Sight.find(params[:sight_id])
        @sight_comments = @sight.sight_comments
        respond_with([@sight, @sight_comment])
    end

    def show
        @sight = Sight.find(params[:sight_id])
        @sight_comment = SightComment.find(params[:id])
        respond_with([@sight, @sight_comment])
    end

    def new
        @sight = Sight.find(params[:sight_id])
        @sight_comment = SightComment.new
        respond_with([@sight, @sight_comment])
    end

    def edit
        @sight = Sight.find(params[:sight_id])
        @sight_comment = SightComment.find(params[:id])
    end

    def create
        params[:sight_comment][:user_id] = current_user
        params[:sight_comment][:sight_id] = params[:sight_id]
        @sight = Sight.find(params[:sight_id])
        @sight_comment = SightComment.new(params[:sight_comment])
        @sight_comment.save
        respond_with([@sight, @sight_comment])
    end

    def update
        @sight = Sight.find(params[:sight_id])
        @sight_comment = SightComment.find(params[:id])
        @sight_comment.update_attributes(params[:sight_comment])
        respond_with([@sight, @sight_comment])
    end

    def destroy
        @sight = Sight.find(params[:sight_id])
        @sight_comment = SightComment.find(params[:id])
        @sight_comment.destroy
        respond_with([@sight, @sight_comment])
    end
end
