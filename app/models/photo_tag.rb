class PhotoTag < ActiveRecord::Base
    belongs_to :photo
    belongs_to :user
    validates_presence_of :tag, :photo_id, :user_id
    validates_associated :photo, :user
    validates_length_of :tag, :maximum => 60
end
