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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160202081535) do

  create_table "activities", force: :cascade do |t|
    t.integer  "log_id",        limit: 4
    t.string   "log_type",      limit: 255
    t.string   "content",       limit: 255
    t.string   "activity_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "word_id",    limit: 4
    t.string   "content",    limit: 255
    t.boolean  "correct"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "picture",     limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "lesson_words", force: :cascade do |t|
    t.integer  "lesson_id",  limit: 4
    t.integer  "word_id",    limit: 4
    t.integer  "answer_id",  limit: 4
    t.boolean  "correct"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "lesson_words", ["lesson_id"], name: "index_lesson_words_on_lesson_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "category_id", limit: 4
    t.string   "result",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "lessons", ["category_id"], name: "index_lessons_on_category_id", using: :btree
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",        limit: 255
    t.string   "last_name",         limit: 255
    t.string   "email",             limit: 255
    t.string   "password_digest",   limit: 255
    t.string   "avatar",            limit: 255
    t.boolean  "admin",                         default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "remember_digest",   limit: 255
    t.string   "activation_digest", limit: 255
    t.boolean  "activated"
    t.datetime "activated_at"
  end

  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree

  create_table "words", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.string   "content",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "words", ["category_id"], name: "index_words_on_category_id", using: :btree

end
