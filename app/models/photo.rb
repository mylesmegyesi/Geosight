class Photo < ActiveRecord::Base
  belongs_to :sight
  has_many :photocomments
  has_attached_file :pic, 
    :styles => { 
      :medium => "300x300>", 
      :thumb => "100x100>"
      }
end
