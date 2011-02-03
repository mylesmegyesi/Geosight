class SightRating < ActiveRecord::Base
    belongs_to :sight
    belongs_to :user
    validates_presence_of :rating, :sight_id, :user_id
    validates_associated :sight, :user
    validates_numericality_of :rating, :only_integer => true,
        :greater_than_or_equal_to => 1,
        :less_than_or_equal_to => 5
end
