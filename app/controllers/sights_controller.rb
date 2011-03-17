class SightsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json

    def index
        @sights = Sight.all
        respond_with(@sights) do |format|
			format.html { render :layout => 'map'}
		end
    end

    def show
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            sight_not_found
        end
        respond_with(@sight) do |format|
            format.html { render :layout => 'map' }
        end
    end

    def new
        @sight = Sight.new
        respond_with(@sight)
    end

    def edit
        @sight = Sight.find_by_ids(params[:id])
        if @sight.nil?
            sight_not_found
        end
    end

    def create
        
        ## Move Photos to Unassigned
        @sight = Sight.new(params[:sight])
        @sight.save
        respond_with(@sight)
    end

    def update
        @sight = Sight.find_by_ids(params[:id])
        if @sight.nil?
            sight_not_found
        end
        @sight.update_attributes(params[:sight])
        respond_with(@sight)
    end

    def destroy
        @sight = Sight.find(params[:id])
        @sight.destroy
        respond_with(@sight)
    end
end
