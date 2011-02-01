class CreateSights < ActiveRecord::Migration
  def self.up
    create_table :sights do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.float :radius
      t.date :timestape

      t.timestamps
    end
  end

  def self.down
    drop_table :sights
  end
end
