class Photo < ActiveRecord::Base
    belongs_to :sight
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :tags, :dependent => :destroy
    validates_presence_of :sight_id, :user_id, :file, :latitude, :longitude
    validates_associated :sight, :user
    has_attached_file :file, 
    :styles => {
        :medium => "300x300>",
        :thumb => "100x100>"
        },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",
    :path => "/photos/:id/:style.:filename"
end
