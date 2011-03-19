class Tag < ActiveRecord::Base
    has_and_belongs_to_many :photos
    has_and_belongs_to_many :sights
    validates_length_of :tag, :minimum => 1, :maximum => 20, :if => :tag?
    
    private
    
    def rating?
        if self.tag.nil?
            errors.add(:tag, "not present")
            return false
        end
        return true
    end
    
end
