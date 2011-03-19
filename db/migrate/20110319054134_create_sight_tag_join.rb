class CreateSightTagJoin < ActiveRecord::Migration
    def self.up
        create_table :sights_tags, :id => false do |t|
            t.integer :sight_id
            t.integer :tag_id
        end
    end

    def self.down
        drop_table :sights_tags
    end
end
