class Sight < ActiveRecord::Base
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :ratings, :dependent => :destroy
    has_and_belongs_to_many :photos
    has_and_belongs_to_many :tags
    validates_length_of :name, :minimum => 1, :maximum => 20, :if => :name?
    validates_numericality_of :latitude, :if => :latitude?
    validates_numericality_of :longitude, :if => :longitude?
    validates_numericality_of :radius, :less_than_or_equal_to => 200, :if => :radius?
    after_save :update_photos
    before_destroy :remove_photos
    before_save :set_user_id
    
    def rating
        Rating.average(:rating, :condtions => ["sight_id = ?", self.id])
    end

	def self.search(search)
    	if search
			find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
		else
			find(:all)
	  	end
	end

    def self.find_sights(latitude, longitude)
        to = GeoKit::LatLng.new(latitude, longitude)
        Sight.all.select { |sight|
            from = GeoKit::LatLng.new(sight.latitude, sight.longitude)
            if (from.distance_to(to)*1000) < sight.radius
                sight
            end
        }
    end
    
    def as_json(options = {})
        if (photos.length > 0)
            photo = photos.at(0)
            pics = {
                :thumbnail => photo.file.url(:thumb),
                :small => photo.file.url(:small),
				:smaller => photo.file.url(:smaller),
                :medium => photo.file.url(:medium),
                :original => photo.file.url
            }
        else
            pics = {}
        end
        {
            :id => id,
            :user_id => user_id,
            :name => name,
            :radius => radius,
            :latitude => latitude,
            :longitude => longitude
        }.merge(pics)
    end
    
    private
    
    def set_user_id
        self.user_id = User.current_user.id
    end
    
    # Add photos to this sight
    def update_photos
        self.photos = Photo.find_photos(latitude, longitude, radius)
    end
    
    def remove_photos
        self.photos.clear
    end
    
    def name?
        if name.nil?
            errors.add(:name, "can't be blank")
            return false
        end
        return true
    end
    
    def latitude?
        if latitude.nil?
            errors.add(:base, "GPS location not present")
            return false
        end
        return true
    end
      
    def longitude?
        if longitude.nil?
            errors.add(:base, "GPS location not present")
            return false
        end
        return true
    end
    
    def radius?
        if radius.nil?
            errors.add(:radius, "can't be blank")
            return false
        end
        return true
    end
end
