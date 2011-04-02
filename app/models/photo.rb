class Photo < ActiveRecord::Base
    belongs_to :sight
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :ratings, :dependent => :destroy
    has_and_belongs_to_many :tags
    validates_associated :user, :if => :user?
    validate :gps_data
    has_attached_file :file, {
        :styles => {
            :medium => "x450>",
            :small => "x300>",
            :thumb => "x100>"
        }
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
    
    # Virtual fields to trick the form builder
    def name
    end
    def name=(name)
    end
    def radius
    end
    def radius=(radius)
    end
    def existing_sight_id
    end
    def existing_sight_id=(existing_sight_id)
    end
    
    private
    
    def user?
        if self.user.nil?
            errors.add(:user, "not present")
            return false
        end
        return true
    end
    
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
