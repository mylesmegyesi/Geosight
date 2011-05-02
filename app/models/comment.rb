class Comment < ActiveRecord::Base
    belongs_to :photo
    belongs_to :sight
    belongs_to :user
    validates_presence_of :comment
    validate :parent?
    before_save :set_user_id
    
    # Pretty format the date of creation
    def date
        created_at.strftime("%B %e, %Y")
    end
    
    # Pretty format the time created
    def time
        created_at.strftime("%l:%M %P")
    end
    
    # A virtual accessor to get the parent of this instance
    def parent
        if not sight_id.nil?
            Sight.find_by_id(sight_id)
        else
            Photo.find_by_id(photo_id)
        end
    end
    
    private
    
    def set_user_id
        self.user_id = User.current_user.id
    end
    
    # Validates whether a parent object was given
    def parent?
        if not sight_id.nil?
            if Sight.find_by_id(sight_id).nil?
                errors.add(:base, "Sight doesn't exist")
            end
        elsif not photo_id.nil?
            if Photo.find_by_id(photo_id).nil?
                errors.add(:base, "Photo doesn't exist")
            end
        else
            errors.add(:base, "No photo or sight specified")
        end
    end
end
