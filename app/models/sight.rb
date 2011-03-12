class Sight < ActiveRecord::Base
    belongs_to :user
    has_many :photos, :dependent => :destroy
    has_many :sight_comments, :dependent => :destroy
    has_many :sight_ratings, :dependent => :destroy
    validates_associated :user
    validates_presence_of :user_id, :name, :radius, :latitude, :longitude
    validates_length_of :name, :maximum => 20
    validates_numericality_of :latitude
    validates_numericality_of :longitude
    validates_numericality_of :radius, :less_than_or_equal_to => 100 # max 100 meter radius
    
    def self.possible_sights(latitude, longitude)
        to = GeoKit::LatLng.new(latitude, longitude)
        Sight.all.select { |sight|
            from = GeoKit::LatLng.new(sight.latitude, sight.longitude)
            if (from.distance_to(to)*1000) < sight.radius
                sight
            end
        }
    end
end
