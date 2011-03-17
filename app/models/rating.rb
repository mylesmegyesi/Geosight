class SightRating < ActiveRecord::Base
    belongs_to :photo
    belongs_to :sight
    belongs_to :user
    validates_presence_of :rating, :user_id
    validates_numericality_of :rating, :only_integer => true,
        :greater_than_or_equal_to => 1,
        :less_than_or_equal_to => 5
    validates_associated :user
    validate :parent
        
    protected
    def parent
        if not self.sight_id.nil?
            if Sight.find_by_id(self.sight_id).nil?
                errors.add_to_base("Sight doesn't exist")
            end
        elsif not self.photo_id.nil?
            if Photo.find_by_id(self.photo_id).nil?
                errors.add_to_base("Photo doesn't exist")
            end
        else
            errors.add_to_base("No photo or sight specified")
        end
    end
end
