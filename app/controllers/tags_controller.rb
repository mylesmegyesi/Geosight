class TagsController < ApplicationController
    before_filter :require_user, :except => [:show]
    respond_to :html, :json    
	
	def index
        @tags = Tag.search(params[:search])
        respond_with(@tags)        
    end

    def show
        @tag = Tag.find_by_id(params[:id])
        if @tag.nil?
            redirect_to not_found_path
            return
        end
        respond_with(@tag)
    end

    def create        
        
        if params[:tag].nil?
            redirect_to not_found_path
            return
        end
        
        if not params[:photo_id].nil?
            @parent = Photo.find_by_id(params[:photo_id])
        elsif not params[:sight_id].nil?
            @parent = Sight.find_by_id(params[:sight_id])
        else
            redirect_to not_found_path
            return
        end
        
        if params[:tag][:tag].nil?
            redirect_to not_found_path
            return
        end
        
        is_tagged = false
        @parent.tags.each do |tag|
            if tag.tag == params[:tag][:tag]
                is_tagged = true
                flash[:error] = "Photo already has that tag!"
            end
        end
        if not is_tagged
            params[:tag][:user_id] = current_user.id
            
            @tag = Tag.find_by_tag(params[:tag][:tag])
            
            if @tag.nil?
                @tag = Tag.new(params[:tag])
                if @tag.save
                    flash[:notice] = "Tag successfully created"
                    @parent.tags << @tag
                else
                    flash[:error] = "There was a problem creating your Tag"
                end 
            else
               @parent.tags << @tag  
            end               
            
        end
        
        respond_with(@tag) do |format|
            format.html { respond_with(@parent) }
        end
    end

    def destroy
        @tag = Tag.find_by_id(params[:id])
        if @tag.nil?
            redirect_to not_found_path
            return
        end
        
        if not params[:photo_id].nil?
            @parent = Photo.find_by_id(params[:photo_id])
        elsif not params[:sight_id].nil?
            @parent = Sight.find_by_id(params[:sight_id])
        else
            respond_to do |format|
                format.html {
                    flash[:error] = "There was a problem deleting your tag"
                    redirect_to not_found_path
                    return
                }
                format.json {
                    render :nothing, :status => 404
                    return
                }
            end
        end
        
        @parent.tags.delete(@tag)
        
        if @tag.photos.nil? && @tag.sights.nil?
            @tag.destroy
        end
        
        flash[:notice] = "Tag successfully deleted"
        respond_with(@tag) do |format|
            format.html { respond_with(@parent) }
        end
    end
end
