class CreateTags < ActiveRecord::Migration
    def self.up
        create_table :tags do |t|
            t.integer :user_id
            t.integer :photo_id
            t.integer :sight_id
            t.text :tag
            t.timestamps
        end
    end
    
    def self.down
        drop_table :tags
    end
end
