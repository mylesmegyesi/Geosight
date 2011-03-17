class UnassignedsController < ApplicationController
    before_filter :require_user, :except => [:index] 
    respond_to :html, :json
    
    def index
        @user = current_user
        @photos = @user.unassigneds
    end

    def show
        @unassigned = Unassigned.find(params[:id])
        redirect_to edit_unassigned_path(@photo)
    end

    def new
        @unassigned = Unassigned.new
    end

    def edit
        @unassigned = Unassigned.find(params[:id])
                        
        @possible_sights = Sight.possible_sights(@unassigned.latitude, 
            @unassigned.longitude).map { |sight| [sight.name, sight.id] }
        
        # Add an empty sight to the beginning of the array
        @possible_sights.unshift(["", 0])
    end

    def create       
        @unassigned = Unassigned.new(params[:unassigned])
        @unassigned.save
        respond_with(@photo) do |format|
            format.json {
                # Here we need to generate a list of possible sights that
                # this picture could be put into. Store the list in @possible_sights
                @possible_sights = Sight.possible_sights(@photo.latitude, @photo.longitude)
                
                respond_with(@photo, @possible_sights)
            }
        end
    end

    def update
        
        @unassigned = Unassigned.find(params[:id])
        
        if params[:old_sight_id] == "0"
            @sight = Sight.new
            @sight.name = params[:name]
            @sight.radius = params[:radius]
            @sight.latitude = @unassigned.latitude
            @sight.longitude = @unassigned.longitude
            @sight.user_id = current_user.id
            
            if not @sight.save
                respond_with(@unassigned)
            end
        else
            @sight = Sight.find(params[:old_sight_id])
        end
        
        @photo = Photo.new(:sight_id => @sight.id, :user_id => @unassigned.user_id, 
            :file => @unassigned.file, :latitude => @unassigned.latitude, 
            :longitude => @unassigned.longitude)
        
        if @photo.save
            @unassigned.destroy
            respond_with([@sight, @photo])
        else
            respond_with(@unassigned, @photo)
        end
    end

    def destroy
        @unassigned = Unassigned.find(params[:id])
        @unassigned.destroy
        respond_with(@unassigned)
    end    
end
