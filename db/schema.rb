# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110201010103) do

  create_table "photo_comments", :force => true do |t|
    t.string   "body"
    t.integer  "photo_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_tags", :force => true do |t|
    t.integer  "photo_id",   :null => false
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "sight_id",         :null => false
    t.string   "pic_filename"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sight_comments", :force => true do |t|
    t.string   "body"
    t.integer  "sight_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sight_ratings", :force => true do |t|
    t.integer  "sight_id",   :null => false
    t.integer  "user_id",    :null => false
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sights", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.float    "radius"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
