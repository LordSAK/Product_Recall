# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20131220104644) do

  create_table "histories", :force => true do |t|
    t.datetime "TimeLogin"
    t.datetime "TimeLogout"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "histories", ["user_id", "created_at"], :name => "index_histories_on_user_id_and_created_at"

  create_table "recalls", :force => true do |t|
    t.string   "Category"
    t.text     "Title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "Summary"
    t.text     "Details"
    t.string   "Manufacturer"
    t.string   "Products"
    t.string   "Hazards"
    t.string   "vendor"
    t.string   "supplier"
  end

  create_table "searches", :force => true do |t|
    t.string   "searches"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "searches", ["user_id", "created_at"], :name => "index_searches_on_user_id_and_created_at"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "suppliers", :force => true do |t|
    t.string   "supplier"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "suppliers", ["user_id", "created_at"], :name => "index_suppliers_on_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "FirstName"
    t.string   "LastName"
    t.string   "email"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  :default => false
    t.string   "cell_no"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "usertype",               :default => "Basic"
    t.integer  "alerts"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "paid_Alert",             :default => 40
    t.integer  "basic_Alert",            :default => 10
    t.string   "Advance_Search_allow",   :default => "No"
    t.string   "alert_type"
    t.integer  "num_of_keywords"
    t.integer  "basic_keyword"
    t.integer  "paid_keyword"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "vendors", :force => true do |t|
    t.string   "vendor"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "vendors", ["user_id", "created_at"], :name => "index_vendors_on_user_id_and_created_at"

end
