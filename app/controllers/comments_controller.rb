class CommentsController < ApplicationController
    before_filter :require_user
    respond_to :html, :json

    def create
        @comment = Comment.new(params[:comment])
        if @comment.save
            flash[:notice] = "Comment successfully posted"
        else
            flash[:error] = "There was a problem posting your comment"
        end
        respond_with_parent(@comment, @comment.photo, @comment.sight)
    end

    def update
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
            redirect_to not_found_path
            return
        end
        if @comment.update_attributes(params[:comment])
            flash[:notice] = "Comment successfully updated"
        else
            flash[:error] = "There was a problem updating your Comment"
        end
        respond_with_parent(@comment, @comment.photo, @comment.sights)
    end

    def destroy        
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
            redirect_to not_found_path
            return
        end
        @sight = @comment.sight
        @photo = @comment.photo
        if @comment.destroy
            flash[:notice] = "Comment successfully deleted"
        else
            flash[:error] = "There was a problem deleting your Comment"
        end
        respond_with_parent(@comment, @photo, @sight)
    end
end
