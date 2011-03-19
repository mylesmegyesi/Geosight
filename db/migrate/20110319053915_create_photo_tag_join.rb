class CreatePhotoTagJoin < ActiveRecord::Migration
    def self.up
        create_table :photos_tags, :id => false do |t|
            t.integer :photo_id
            t.integer :tag_id
        end
    end
    
    def self.down
        drop_table :photos_tags
    end
end
