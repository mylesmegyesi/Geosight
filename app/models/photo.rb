class Photo < ActiveRecord::Base
    belongs_to :sight
    belongs_to :user
    has_many :photo_comments, :dependent => :destroy
    has_many :photo_tags, :dependent => :destroy
    validates_presence_of :sight_id, :user_id, :file
    validates_associated :sight, :user
    has_attached_file :file, 
    :styles => {
        :medium => "300x300>",
        :thumb => "100x100>"
    }
end
