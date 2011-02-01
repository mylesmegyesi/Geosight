class Newsightstable < ActiveRecord::Migration
  def self.up
    create_table :sights do |t|
      t.integer :user_id, :null => false
      t.float :latitude
      t.float :longitude
      t.string :name
      t.float :radius

      t.timestamps
    end
  end

  def self.down
  end
end
