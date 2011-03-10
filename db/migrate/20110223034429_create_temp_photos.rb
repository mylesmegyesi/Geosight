class CreateTempPhotos < ActiveRecord::Migration
  def self.up
    create_table :temp_photos do |t|
       t.integer :user_id
       t.string :file_file_name
       t.string :file_content_type
       t.integer :file_file_size
       t.datetime :file_updated_at
       t.float :latitude
       t.float :longitude
       t.timestamps
    end
  end

  def self.down
    drop_table :temp_photos
  end
end
