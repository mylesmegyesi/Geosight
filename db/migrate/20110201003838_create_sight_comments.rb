class CreateSightComments < ActiveRecord::Migration
  def self.up
    create_table :sight_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :sight_id
      t.timestamps
    end
  end

  def self.down
    drop_table :sight_comments
  end
end
