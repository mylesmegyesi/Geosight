class FixTimestamp < ActiveRecord::Migration
  def self.up
    remove_column :sights, :timestape
  end

  def self.down
  end
end
