class RemoveSightIdFromPhotos < ActiveRecord::Migration
    def self.up
        remove_column :photos, :sight_id
    end
    
    def self.down
        add_column :photos, :sight_id
    end
end
