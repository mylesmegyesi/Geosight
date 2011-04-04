class SightsController < ApplicationController
    before_filter :require_user, :except => [:index, :show]
    respond_to :html, :json

    def index
        @sights = Sight.all
        respond_with(@sights) do |format|
            format.json {
                @sights = @sights.collect do |sight|
                    add_urls_to_sight(sight)
                    sight
                end
                respond_with(@sights)
            }
        end
    end

    def show
        @sight = Sight.find_by_id(params[:id])
        if @sight.nil?
            redirect_to not_found_path
            return
        end
		@tag = Tag.new
		@comment = Comment.new
        respond_with(@sight) do |format|
            format.json {
                add_urls_to_sight(@sight)
                respond_with(@sight)
            }
        end
    end

    def new
        @sight = Sight.new
        respond_with(@sight)
    end

    def edit
        @sight = Sight.find_by_ids(params[:id])
        if @sight.nil?
            redirect_to not_found_path
            return
        end
    end

    def create
        @sight = Sight.new(params[:sight])
        @sight.save
        respond_with(@sight) do |format|
            format.json {
                add_urls_to_sight(@sight)
                respond_with(@sight)
            }
        end
    end

    def update
        @sight = Sight.find_by_ids(params[:id])
        if @sight.nil?
            redirect_to not_found_path
            return
        end
        @sight.update_attributes(params[:sight])
        respond_with(@sight) do |format|
            format.json {
                add_urls_to_sight(@sight)
                respond_with(@sight)
            }
        end
    end

    def destroy
        @sight = Sight.find(params[:id])
        if @sight.nil?
            redirect_to not_found_path
            return
        end
        @sight.photos.each do |photo|
            photo.update_attribute(:sight_id, nil)
        end
        @sight.destroy
        respond_with(@sight)
    end
end
