class CreateSightRatings < ActiveRecord::Migration
  def self.up
    create_table :sight_ratings do |t|
      t.integer :sight_id
      t.integer :user_id
      t.integer :rating
      t.timestamps
    end
  end

  def self.down
    drop_table :sight_ratings
  end
end
