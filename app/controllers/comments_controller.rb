class CommentsController < ApplicationController
    before_filter :require_user
    respond_to :html, :json

    def create
        if params[:comment].nil?
            redirect_to not_found_path
            return
        end
        params[:comment][:user_id] = current_user.id
        @comment = Comment.new(params[:comment])
        if not @comment.save
            flash[:error] = "There was a problem posting your comment"
        end
        respond_with(@comment) do |format|
            format.html {respond_with(@comment.parent) }
        end
    end

    def update
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
            redirect_to not_found_path
            return
        end
        if not @comment.update_attributes(params[:comment])
            flash[:error] = "There was a problem updating your Comment"
        end
        respond_with(@comment) do |format|
            format.html {respond_with(@comment.parent) }
        end
    end

    def destroy        
        @comment = Comment.find_by_id(params[:id])
        if @comment.nil?
            redirect_to not_found_path
            return
        end
        @sight = @comment.sight
        @photo = @comment.photo
        if not @comment.destroy
            flash[:error] = "There was a problem deleting your Comment"
        end
        respond_with(@comment) do |format|
            format.html {respond_with(@comment.parent) }
        end
    end
end
