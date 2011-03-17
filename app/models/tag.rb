class Tag < ActiveRecord::Base
    has_and_belongs_to_many :photo
    has_and_belongs_to_many :sight
    belongs_to :user
    validates_presence_of :tag, :user_id
    validates_length_of :tag, :maximum => 60
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
