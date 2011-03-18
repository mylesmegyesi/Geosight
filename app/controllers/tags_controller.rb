class TagsController < ApplicationController
    before_filter :require_user, :except => [:show]
    respond_to :html, :json    

    def show
        @tag = Tag.find_by_id(params[:id])
        if @tag.nil?
            not_found("", "Tag does not exist", home_path)
            return
        end
        respond_with(@tag)
    end

    def create
        @tag = Tag.new(params[:tag])
        if @tag.save
            flash[:notice] = "Tag successfully created"
        else
            flash[:error] = "TThere was a problem creating your Tag"
        end
        respond_with(@tag)
    end

    def destroy
        @tag = Tag.find_by_id(params[:id])
        if @tag.destroy
            flash[:notice] = "Tag successfully deleted"
        else
            flash[:error] = "There was a problem creating your tag"
        end
        redirect_to home_path
    end
end
