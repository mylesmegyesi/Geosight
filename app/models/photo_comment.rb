class PhotoComment < ActiveRecord::Base
    belongs_to :photo
    belongs_to :user
    validates_presence_of :comment, :photo_id, :user_id
    validates_associated :photo, :user
end
