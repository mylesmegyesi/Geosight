class CreatePhotoComments < ActiveRecord::Migration
  def self.up
    create_table :photo_comments do |t|
      t.string :body
      t.integer :photo_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :photo_comments
  end
end
