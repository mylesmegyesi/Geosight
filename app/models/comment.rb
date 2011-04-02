class Comment < ActiveRecord::Base
    belongs_to :photo
    belongs_to :sight
    belongs_to :user
    validates_presence_of :comment, :user_id
    validates_associated :user
    validate :parent
    
    def date
      self.created_at.strftime("%B %e, %Y")
    end
    
    def time
      self.created_at.strftime("%l:%M %P")
    end
    
    protected
    def parent
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
