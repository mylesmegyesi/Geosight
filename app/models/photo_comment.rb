class PhotoComment < ActiveRecord::Base
    belongs_to :photo
    belongs_to :user
    validates_presence_of :comment, :photo_id, :user_id
    validates_associated :photo, :user
    
    def user_name
      user = User.find(self.user_id)
      user.first_name + " " + user.last_name
    end
    
    def date
      self.created_at.strftime("%B %e, %Y")
    end
    
    def time
      self.created_at.strftime("%l:%M %P")
    end
    
end
