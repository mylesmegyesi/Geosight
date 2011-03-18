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
            flash[:notice] = "Tag successfully created!"
        else
            flash[:error] = "Tag creation unsuccessfull"
        end
        respond_with(@tag)
    end

    def destroy
        @tag = Tag.find_by_id(params[:id])
        if @tag.destroy
            flash[:notice] = "Tag successfully deleted!"
        else
            flash[:error] = "Tag deletion unsuccessful"
        end
        redirect_to home_path
    end
end
