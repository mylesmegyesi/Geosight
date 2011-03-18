class UnassignedsController < ApplicationController
    before_filter :require_user, :except => [:index] 
    respond_to :html, :json
    
    def index
        @user = current_user
        @unassigneds = @user.unassigneds
    end

    def show
        @unassigned = Unassigned.find_by_id(params[:id])
        if @unassigned.nil?
            not_found("", "Unassigned photo doesn't exist", unassigned_index_path)
            return
        end
        @possible_sights = Sight.possible_sights(@unassigned.latitude, 
            @unassigned.longitude).map { |sight| [sight.name, sight.id] }
        @possible_sights.unshift(["", 0])
    end

    def new
        @unassigned = Unassigned.new
    end

    def create       
        @unassigned = Unassigned.new(params[:unassigned])
        @unassigned.save
        respond_with(@unassigned) do |format|
            format.json {
                # Here we need to generate a list of possible sights that
                # this picture could be put into. Store the list in @possible_sights
                @possible_sights = Sight.possible_sights(@photo.latitude, @photo.longitude)
                
                respond_with(@photo, @possible_sights)
            }
        end
    end

    def update
        
        @unassigned = Unassigned.find_by_id(params[:id])
        if @unassigned.nil?
            not_found("", "Unassigned photo doesn't exist", unassigneds_path)
            return
        end
        
        if params[:old_sight_id].nil?
            not_found("", "Old sight ID is blank", unassigned_path(@unassigned))
            return
        end
        
        if params[:old_sight_id] == "0"
            @sight = Sight.new
            @sight.name = params[:name]
            @sight.radius = params[:radius]
            @sight.latitude = @unassigned.latitude
            @sight.longitude = @unassigned.longitude
            @sight.user_id = current_user.id
            
            if not @sight.save
                respond_with(@unassigned, @sight)
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
        @unassigned = Unassigned.find_by_id(params[:id])
        if @unassigned.nil?
            not_found("", "Unassigned photo doesn't exist", unassigneds_path)
            return
        end
        @unassigned.destroy
        respond_with(@unassigned)
    end    
end
