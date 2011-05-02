class Photo < ActiveRecord::Base
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :ratings, :dependent => :destroy
    has_and_belongs_to_many :sights
    has_and_belongs_to_many :tags
    validate :gps_data
    before_save :set_user_id
    after_save :update_sights
    before_destroy :remove_sights
    has_attached_file :file, {
        :styles => {
            :medium => "500x500>",
            :small => "300x300>",
            :smaller => "250x250>",
            :thumb => "100x100>"
        }
    }.merge(PAPERCLIP_STORAGE_OPTIONS)

    # Finds the average rating
    def rating
        rat = Rating.average(:rating, :conditions => ["photo_id = ?", self.id])
        if rat
            rat
        else
            0
        end
    end
    
    # This overwrites a built in Rails function. Changes the way
    # this object is rendered as JSON.
    def as_json(options = {})
        {
            :id => id,
            :user_id => user_id,
            :latitude => latitude,
            :longitude => longitude,
            :thumbnail => file.url(:thumb),
            :small => file.url(:small),
			:smaller => file.url(:smaller),
            :medium => file.url(:medium),
            :original => file.url
        }
    end
     
    # Finds all photos that fit into the given radius at the given location
    def self.find_photos(latitude, longitude, radius)
        to = GeoKit::LatLng.new(latitude, longitude)
        Photo.all.select { |photo|
            from = GeoKit::LatLng.new(photo.latitude, photo.longitude)
            if (from.distance_to(to)*1000) < radius
                photo
            end
        }
    end
    
    private
    
    def set_user_id
        self.user_id = User.current_user.id
    end
    
    def remove_sights
        self.sights.clear
    end
    
    def update_sights
        self.sights = Sight.find_sights(latitude, longitude)
    end
    
    # Extracts the gps data from a photo
    def gps_data
	conversion_factor = 60.0
	lat_multiplier = 1.0
	long_multiplier = 1.0
        if (latitude.nil? or longitude.nil?)
            if file.queued_for_write[:original].nil?
                errors.add(:file, " not selected")
                return
            end
            
            # Extract meta data as a hash
            exif = EXIFR::JPEG.new(file.queued_for_write[:original].path).to_hash
            if not exif[:gps_longitude].nil? # GPS Data Exists
        	ndeg = exif[:gps_latitude][0].to_f
                nmin = exif[:gps_latitude][1].to_f
        	nsec = exif[:gps_latitude][2].to_f
        	edeg = exif[:gps_longitude][0].to_f
        	emin = exif[:gps_longitude][1].to_f
        	esec = exif[:gps_longitude][2].to_f
                    
                # Correct references
                if exif[:gps_latitude_ref] == 'N'
		    lat = lat_multiplier
                else
                    lat = -lat_multiplier
                end
                
                if exif[:gps_longitude_ref] == 'W'
                    lng = -long_multiplier
                else 
                    lng = long_multiplier
                end
                
                lat *= (ndeg + (nmin + (nsec/conversion_factor))/conversion_factor)
        	lng *= (edeg + (emin + (esec/conversion_factor))/conversion_factor)
                
        	self.latitude = lat
                self.longitude = lng
            else
                errors.add(:base, "GPS data not present in file")
            end
        end
    end

end
