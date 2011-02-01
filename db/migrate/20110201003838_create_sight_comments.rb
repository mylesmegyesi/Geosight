class CreateSightComments < ActiveRecord::Migration
  def self.up
    create_table :sight_comments do |t|
      t.string :body
      t.integer :sight_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :sight_comments
  end
end
