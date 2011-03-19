class TagsController < ApplicationController
    before_filter :require_user, :except => [:show]
    respond_to :html, :json    

    def show
        @tag = Tag.find_by_id(params[:id])
        if @tag.nil?
            redirect_to not_found_path
            return
        end
        respond_with(@tag)
    end

    def create
        if not params[:photo_id].nil?
            @parent = Photo.find_by_id(params[:photo_id])
        elsif not params[:sight_id].nil?
            @parent = Sight.find_by_id(params[:photo_id])
        end
        
        if @parent.nil?
            redirect_to not_found_path
            return
        end
        
        if @tag.nil?
            @tag = Tag.find_by_tag(params[:tag][:tag]) 
            @tag = Tag.new(params[:tag])
            if @tag.save
                flash[:notice] = "Tag successfully created"
            else
                flash[:error] = "TThere was a problem creating your Tag"
            end
        end
        
        is_tagged = false
        @parent.tags.each do |tag|
            if tag.tag == @tag.tag
                is_tagged = true
            end
        end
        if not is_tagged
            @parent.tags << @tag
        end
        
        respond_with(@parent) do |format|
            format.json { respond_with(@tag) }
        end
    end

    def destroy
        @tag = Tag.find_by_id(params[:id])
        if @tag.nil?
            redirect_to not_found_path
            return
        end
        
        if params[:photo_id].nil? && params[:sight_id].nil?
            flash[:error] = "There was a problem deleting your tag"
            redirect_to home_path
        elsif not params[:photo_id].nil?
            @parent = Photo.find_by_id(params[:tag][:photo_id])
        elsif not params[:sight_id].nil?
            @parent = Sight.find_by_id(params[:tag][:photo_id])
        end
        
        if @parent.nil?
            redirect_to not_found_path
            return
        end
        
        @parent.tags.delete(@tag)
        
        if @tag.photos.nil? && @tag.sights.nil?
            @tag.destroy
        end
        
        flash[:notice] = "Tag successfully deleted"
        respond_with(@parent)
    end
end
