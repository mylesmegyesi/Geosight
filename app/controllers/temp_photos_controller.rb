class TempPhotosController < ApplicationController
    before_filter :require_user, :except => [:index] 
    respond_to :html, :json, :xml
    
    def index
        @photos = TempPhoto.all
    end

    def show
        @photo = TempPhoto.find(params[:id])
        redirect_to edit_temp_photo_path(@photo)
    end

    def new
        @photo = TempPhoto.new
    end

    def edit
        @photo = TempPhoto.find(params[:id])
                        
        @possible_sights = Sight.possible_sights(@photo.latitude, 
            @photo.longitude).map { |sight| [sight.name, sight.id] }
        
        # Add an empty sight to the beginning of the array
        @possible_sights.unshift(["          ", 0])
        @sight = Sight.new
    end

    def create
        params[:temp_photo][:user_id] = current_user

	# Extract meta data as a hash
        exif = EXIFR::JPEG.new(params[:temp_photo][:file].open).to_hash

        unless exif[:gps_longitude].nil? # GPS Data Exists
		ndeg = exif[:gps_latitude][0].to_f
		nmin = exif[:gps_latitude][1].to_f
		nsec = exif[:gps_latitude][2].to_f
		edeg = exif[:gps_longitude][0].to_f
		emin = exif[:gps_longitude][1].to_f
		esec = exif[:gps_longitude][2].to_f

		# Correct references
		if exif[:gps_latitude_ref] == 'N'
			lat = 1.0
		else 
			lat = -1.0
		end

		if exif[:gps_longitude_ref] == 'W'
			lng = -1.0
		else 
			lng = 1.0
		end
	
		lat *= (ndeg + (nmin + (nsec/60.0))/60.0)
		lng *= (edeg + (emin + (esec/60.0))/60.0)

		# Extract GPS data from picture or access coordinates
		# given to us in params[:latitude] and params[:longitude]
	
		params[:temp_photo][:latitude] = lat
		params[:temp_photo][:longitude] = lng
        
	else 	# No GPS data available
        	# Set dummy coordinates for now
        	params[:temp_photo][:latitude] = 0
       		params[:temp_photo][:longitude] = 0
	end
        	
        @photo = TempPhoto.new(params[:temp_photo])
        @photo.save
        
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
        
        @temp_photo = TempPhoto.find(params[:id])
        
        if params[:old_sight_id] == "0"
            @sight = Sight.new
            @sight.name = params[:name]
            @sight.radius = params[:radius]
            @sight.latitude = @temp_photo.latitude
            @sight.longitude = @temp_photo.longitude
            @sight.user_id = current_user
            
            if not @sight.save
                respond_with(@temp_photo)
            end
        else
            @sight = Sight.find(params[:old_sight_id])
        end
        
        @photo = Photo.new(:sight_id => @sight.id, :user_id => @temp_photo.id, :file => @temp_photo.file, :latitude => @temp_photo.latitude, :longitude => @temp_photo.longitude)
        
        if @photo.save
            @temp_photo.destroy
            respond_with([@sight, @photo])
        else
            respond_with(@temp_photo)
        end
    end

    def destroy
        @photo = TempPhoto.find(params[:id])
        @photo.destroy
        respond_with(@photo)
    end
end
