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

ActiveRecord::Schema.define(version: 20131211012753) do

  create_table "genres", force: true do |t|
    t.string "name"
  end

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.string   "new_user_email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer "user_id"
    t.integer "amount"
    t.string  "reference_id"
  end

  create_table "queued_videos", force: true do |t|
    t.integer  "user_id"
    t.integer  "video_id"
    t.integer  "queue_position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "rating"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.boolean  "admin"
    t.string   "stripe_customer_id"
    t.boolean  "active",             default: true
  end

  create_table "video_genres", force: true do |t|
    t.integer "video_id"
    t.integer "genre_id"
  end

  create_table "videos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "poster_url"
    t.string   "small_cover_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
  end

end
