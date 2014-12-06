# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140522052056) do

  create_table "assets", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "src_file_name"
    t.string   "src_content_type"
    t.string   "src_file_size"
    t.datetime "src_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "banners", :force => true do |t|
    t.string   "name"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at"
  end

  create_table "buzzs", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "root_id"
    t.boolean  "from_user_deleted"
    t.boolean  "to_user_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", :force => true do |t|
    t.text     "upload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geocodes", :force => true do |t|
    t.decimal "latitude",    :precision => 15, :scale => 12
    t.decimal "longitude",   :precision => 15, :scale => 12
    t.string  "query"
    t.string  "street"
    t.string  "locality"
    t.string  "region"
    t.string  "postal_code"
    t.string  "country"
    t.string  "precision"
  end

  add_index "geocodes", ["country"], :name => "geocodes_country_index"
  add_index "geocodes", ["latitude"], :name => "geocodes_latitude_index"
  add_index "geocodes", ["locality"], :name => "geocodes_locality_index"
  add_index "geocodes", ["longitude"], :name => "geocodes_longitude_index"
  add_index "geocodes", ["postal_code"], :name => "geocodes_postal_code_index"
  add_index "geocodes", ["precision"], :name => "geocodes_precision_index"
  add_index "geocodes", ["query"], :name => "geocodes_query_index", :unique => true
  add_index "geocodes", ["region"], :name => "geocodes_region_index"

  create_table "geocodings", :force => true do |t|
    t.integer  "geocodable_id"
    t.integer  "geocode_id"
    t.string   "geocodable_type"
    t.datetime "created_at"
  end

  add_index "geocodings", ["geocodable_id"], :name => "geocodings_geocodable_id_index"
  add_index "geocodings", ["geocodable_type"], :name => "geocodings_geocodable_type_index"
  add_index "geocodings", ["geocode_id"], :name => "geocodings_geocode_id_index"

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paragraphs", :force => true do |t|
    t.integer  "story_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "path"
    t.string   "subject"
    t.string   "age"
    t.string   "gender"
    t.boolean  "fiction"
    t.integer  "year",                :limit => 8
    t.string   "location"
    t.string   "author_location"
    t.boolean  "use_author_location"
    t.boolean  "anonymous",                        :default => false
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "featured_at"
    t.text     "body"
    t.string   "state"
    t.string   "country"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.boolean  "player_location"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.datetime "dob"
    t.string   "bio",                       :limit => 40
    t.string   "interests",                 :limit => 40
    t.boolean  "gender"
    t.string   "city",                      :limit => 100, :default => ""
    t.string   "state",                     :limit => 100, :default => ""
    t.string   "country",                   :limit => 100, :default => ""
    t.float    "latitude"
    t.float    "longitude"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "ip_address",                :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.boolean  "agreed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_code",       :limit => 40
    t.datetime "reset_at"
    t.boolean  "buzz_me",                                  :default => true
    t.boolean  "buzz_me_mail",                             :default => true
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "view_counts", :force => true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.string   "ip_address"
    t.boolean  "logged_in"
    t.datetime "created_at"
  end

end
