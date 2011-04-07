class Rating < ActiveRecord::Base
    belongs_to :photo
    belongs_to :sight
    belongs_to :user
    validate :parent?
    validates_associated :user, :if => :user?
    validates_numericality_of :rating, :only_integer => true,
        :greater_than_or_equal_to => 1,
        :less_than_or_equal_to => 5, :if => :rating?
        
    def parent
        if not sight_id.nil?
            Sight.find_by_id(sight_id)
        else
            Photo.find_by_id(photo_id)
        end
    end
        
    private 
    
    def user?
        if self.user.nil?
            errors.add(:user, "not present")
            return false
        end
        return true
    end
    
    def rating?
        if self.rating.nil?
            errors.add(:rating, "not present")
            return false
        end
        return true
    end
    
    def parent?
        if not self.sight_id.nil?
            if Sight.find_by_id(self.sight_id).nil?
                errors.add(:base, "Sight doesn't exist")
            end
        elsif not self.photo_id.nil?
            if Photo.find_by_id(self.photo_id).nil?
                errors.add(:base, "Photo doesn't exist")
            end
        else
            errors.add(:base, "No photo or sight specified")
        end
    end
end
