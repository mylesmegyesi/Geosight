class TempPhoto < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :user_id, :file, :latitude, :longitude
    before_validation :get_gps_data
    validates_associated :user
    has_attached_file :file, 
        :storage => :s3,
        :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
        :path => "/temp_photos/:id/:style.:filename"
        :styles => {
            :medium => "300x300>",
            :thumb => "100x100>"
        }
    
    protected
    def get_gps_data
        if file.queued_for_write[:original].nil?
            errors.add(:file, "not present")
            return
        end
        if (latitude.nil? or longitude.nil?)
            # Extract meta data as a hash
            exif = EXIFR::JPEG.new(file.queued_for_write[:original]).to_hash
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
                errors.add(:latitude, "not present in file")
                errors.add(:longitude, "not present in file")
            end
        end
    end
end
