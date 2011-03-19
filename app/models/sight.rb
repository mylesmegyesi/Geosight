class Sight < ActiveRecord::Base
    belongs_to :user
    has_many :photos
    has_many :comments, :dependent => :destroy
    has_many :ratings, :dependent => :destroy
    has_and_belongs_to_many :tags
    validates_associated :user, :if => :user?
    validates_length_of :name, :minimum => 1, :maximum => 20, :if => :name?
    validates_numericality_of :latitude, :if => :location?
    validates_numericality_of :longitude, :if => :location?
    validates_numericality_of :radius, :less_than_or_equal_to => 50, :if => :radius?
    
    def rating
        Rating.average(:rating, :condtions => ["id = ?", self.id])
    end
    
    def self.possible_sights(latitude, longitude)
        to = GeoKit::LatLng.new(latitude, longitude)
        Sight.all.select { |sight|
            from = GeoKit::LatLng.new(sight.latitude, sight.longitude)
            if (from.distance_to(to)*1000) < sight.radius
                sight
            end
        }
    end
    
    private
    
    def user?
        if self.user.nil?
            errors.add(:user, "not present")
            return false
        end
        return true
    end
    
    def name?
        if self.name.nil?
            errors.add(:name, "can't be blank")
            return false
        end
        return true
    end
    
    def location?
        if self.latitude.nil?
            errors.add_to_base("GPS location not present")
            return false
        end
        
        if self.longitude.nil?
            errors.add_to_base("GPS location not present")
            return false
        end
        return true
    end
    
    def radius?
        if self.radius.nil?
            errors.add(:radius, "can't be blank")
            return false
        end
        return true
    end
end
