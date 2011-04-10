class Photo < ActiveRecord::Base
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :ratings, :dependent => :destroy
    has_and_belongs_to_many :sights
    has_and_belongs_to_many :tags
    validates_presence_of :user_id
    validates_associated :user
    validate :gps_data
    has_attached_file :file, {
        :styles => {
            :medium => "500x500>",
            :small => "300x300>",
            :thumb => "100x100>"
        }
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
    
    def as_json(options = {})
        {
            :id => id,
            :user_id => user_id,
            :latitude => latitude,
            :longitude => longitude,
            :thumbnail => file.url(:thumb),
            :small => file.url(:small),
            :medium => file.url(:medium),
            :original => file.url
        }
    end
     
    def self.find_photos(latitude, longitude, radius)
        to = GeoKit::LatLng.new(latitude, longitude)
        Photo.all.select { |photo|
            from = GeoKit::LatLng.new(photo.latitude, photo.longitude)
            if (from.distance_to(to)*1000) < radius
                sight
            end
        }
    end
    
    private
    
    def gps_data
        if (latitude.nil? or longitude.nil?)
            if file.queued_for_write[:original].nil?
                errors.add(:file, "not selected")
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
                
        		self.latitude = lat
                self.longitude = lng
            else
                errors.add(:base, "GPS data not present in file")
            end
        end
    end
end
