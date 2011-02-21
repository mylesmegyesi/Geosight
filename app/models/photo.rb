class Photo < ActiveRecord::Base
    belongs_to :sight
    belongs_to :user
    has_many :photo_comments, :dependent => :destroy
    has_many :photo_tags, :dependent => :destroy
    validates_presence_of :sight_id, :user_id, :file, :latitude, :longitude
    validates_associated :sight, :user
    has_attached_file :file,
        :storage => :s3,
        :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
        :path => "/sight_photos/:id/:style.:filename"
    :styles => {
        :medium => "300x300>",
        :thumb => "100x100>"
        }
end
