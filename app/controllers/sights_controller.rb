class SightsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json

    def index

		if params[:tag_search] && params[:tag_search] == "1"
			redirect_to :controller => :tags, :action => :index, :utf8 => params[:utf8], :search => params[:search] 
		else        	
			@sights = Sight.search(params[:search])
			respond_with(@sights)
		end
		     
    end

    def show
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
		@tag = Tag.new
		@comment = Comment.new
        respond_with(@sight)
    end

    def new
        @sight = Sight.new
    end

    def edit
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
    end

    def create
        @sight = Sight.new(params[:sight])
        if not @sight.save
            flash[:error] = "There was a problem saving your Sight"
        end
        respond_with(@sight)
    end

    def update        
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
        if not @sight.update_attributes(params[:sight])
            flash[:error] = "There was a problem updating your Sight"
        end
        respond_with(@sight)
    end

    def destroy
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            flash[:error] = "Sight not found"
            redirect_to not_found_path
            return
        end
        if not @sight.destroy
            flash[:error] = "There was a problem deleting your Sight"
        end
        respond_with(@sight)
    end
end
