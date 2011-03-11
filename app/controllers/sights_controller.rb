class SightsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json, :xml

    def index
        @sights = Sight.all
        respond_with(@sights)
    end

    def show
        @sight = Sight.find(params[:id])
        respond_with(@sight) do
            format.html { render :layout => 'map' }
        end
    end

    def new
        @sight = Sight.new
        respond_with(@sight)
    end

    def edit
        @sight = Sight.find(params[:id])
    end

    def create
        if !params[:sight].nil?
            params[:sight][:user_id] = current_user
        end
        @sight = Sight.new(params[:sight])
        @sight.save
        respond_with(@sight)
    end

    def update
        @sight = Sight.find(params[:id])
        @sight.update_attributes(params[:sight])
        respond_with(@sight)
    end

    def destroy
        @sight = Sight.find(params[:id])
        @sight.destroy
        respond_with(@sight)
    end
end
