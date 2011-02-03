class SightComment < ActiveRecord::Base
    belongs_to :sight
    belongs_to :user
    validates_presence_of :comment, :sight_id, :user_id
    validates_associated :sight, :user
end
