class TempPhoto < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :user_id, :file, :latitude, :longitude
    validates_associated :user
    has_attached_file :file, 
        :styles => {
            :medium => "300x300>",
            :thumb => "100x100>"
            },
        :url => "/system/temp_photos/:id/:style.:filename",
        :path => ":rails_root/public/system/temp_photos/:id/:style.:filename"
    
end
