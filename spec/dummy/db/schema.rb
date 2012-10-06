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

ActiveRecord::Schema.define(:version => 20121006021935469186) do

  create_table "categoryz3_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "items_count",       :default => 0
    t.integer  "child_items_count", :default => 0
    t.integer  "childrens_count",   :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "categoryz3_categories", ["name"], :name => "index_categoryz3_categories_on_name"
  add_index "categoryz3_categories", ["parent_id"], :name => "index_categoryz3_categories_on_parent_id"

  create_table "categoryz3_child_items", :force => true do |t|
    t.integer  "category_id",        :null => false
    t.integer  "categorizable_id",   :null => false
    t.string   "categorizable_type", :null => false
    t.integer  "master_item_id",     :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "categoryz3_child_items", ["categorizable_type", "categorizable_id"], :name => "child_items_categorizable_idx"
  add_index "categoryz3_child_items", ["category_id", "categorizable_type", "categorizable_id"], :name => "child_items_unq_idx", :unique => true
  add_index "categoryz3_child_items", ["category_id", "created_at"], :name => "index_categoryz3_child_items_on_category_id_and_created_at"
  add_index "categoryz3_child_items", ["master_item_id"], :name => "index_categoryz3_child_items_on_master_item_id"

  create_table "categoryz3_items", :force => true do |t|
    t.integer  "category_id",        :null => false
    t.integer  "categorizable_id",   :null => false
    t.string   "categorizable_type", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "categoryz3_items", ["categorizable_type", "categorizable_id"], :name => "items_categorizable_idx"
  add_index "categoryz3_items", ["category_id", "categorizable_type", "categorizable_id"], :name => "items_unq_idx", :unique => true
  add_index "categoryz3_items", ["category_id", "created_at"], :name => "index_categoryz3_items_on_category_id_and_created_at"

  create_table "dummy_objects", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
