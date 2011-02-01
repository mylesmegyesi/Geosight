class CreateSightRatings < ActiveRecord::Migration
  def self.up
    create_table :sight_ratings do |t|
      t.integer :sight_id, :null => false
      t.integer :user_id, :null => false
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :sight_ratings
  end
end
