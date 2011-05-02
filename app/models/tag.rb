class Tag < ActiveRecord::Base
    has_and_belongs_to_many :photos
    has_and_belongs_to_many :sights
    validates_length_of :tag, :minimum => 1, :maximum => 20, :if => :tag?
    before_save :set_user_id
    
    private
    
    # Finds the current user id from the cookies and sets it to the 
    # user id of this instance 
    def set_user_id
        self.user_id = User.current_user.id
    end
    
    # Validates that a tag is present
    # if not, this tag is rejected
    def tag?
        if self.tag.nil?
            errors.add(:tag, "not present")
            return false
        end
        return true
    end

    # Given a string, finds tags that are similar
    def self.search(search)
    	if search
            find(:all, :conditions => ['tag LIKE ?', "%#{search}%"])
        else
            find(:all)
        end
    end

end
