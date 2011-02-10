class TempPhoto < ActiveRecord::Base
    belongs_to :user
    has_many :photo_comments, :dependent => :destroy
    has_many :photo_tags, :dependent => :destroy
    validates_presence_of :user_id, :file
    validates_associated :user
    has_attached_file :file, 
    :styles => {
        :medium => "300x300>",
        :thumb => "100x100>"
    }
end
