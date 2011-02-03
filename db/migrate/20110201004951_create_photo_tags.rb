class CreatePhotoTags < ActiveRecord::Migration
  def self.up
    create_table :photo_tags do |t|
      t.integer :photo_id
      t.integer :user_id
      t.text :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :photo_tags
  end
end
