class Newphotostable < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
       t.integer :sight_id, :null => false
       t.string :pic_filename
       t.string :pic_content_type
       t.integer :pic_file_size
       t.datetime :pic_updated_at

       t.timestamps
    end
  end

  def self.down
  end
end
