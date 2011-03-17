class CommentsController < ApplicationController
    before_filter :require_user
    respond_to :html, :json

    def create
        @comment = Comment.new(params[:comment])
        @comment.save
        respond_with_parent(@comment, @comment.photo, @comment.sight)
    end

    def update
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
            comment_not_found
        end
        @comment.update_attributes(params[:comment])
        @comment.save
        respond_with_parent(@comment, @comment.photo, @comment.sights)
    end

    def destroy        
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
            comment_not_found
        end
        @sight = @comment.sight
        @photo = @comment.photo
        @comment.destroy
        respond_with_parent(@comment, @photo, @sight)
    end
end
