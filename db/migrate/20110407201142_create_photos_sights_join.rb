class CreatePhotosSightsJoin < ActiveRecord::Migration
    def self.up
        create_table :photos_sights, :id => false do |t|
            t.integer :photo_id
            t.integer :sight_id
        end
    end
    
    def self.down
        drop_table :photos_sights
    end
end
