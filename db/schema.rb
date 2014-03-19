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

ActiveRecord::Schema.define(version: 20140319222531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_users", force: true do |t|
    t.string   "token"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accuracy"
    t.string   "push_token"
    t.string   "type"
    t.string   "kind"
  end

  create_table "bonuses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  create_table "cities", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.string   "email"
    t.string   "twitter_name"
    t.string   "hashtag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vk_name"
    t.string   "yandex_widget"
  end

  create_table "city_streets", force: true do |t|
    t.string   "name"
    t.integer  "rate"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "classifier_features", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "count",      default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  create_table "posts", force: true do |t|
    t.string   "user_name"
    t.string   "title"
    t.text     "content"
    t.string   "state"
    t.datetime "published_at"
    t.string   "seo_name"
    t.string   "seo_keywords"
    t.string   "seo_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "city_id"
    t.string   "text"
    t.datetime "time"
    t.string   "state"
    t.string   "sourceable_id"
    t.string   "sourceable_type"
    t.string   "source_kind"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "id_str"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_kind"
    t.string   "source_text"
    t.integer  "accuracy"
  end

  create_table "streets", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.integer  "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitter_users", force: true do |t|
    t.string   "profile_image_url"
    t.string   "name"
    t.string   "screen_name"
    t.string   "id_str"
    t.string   "state"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  create_table "vk_users", force: true do |t|
    t.string   "state"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vk_id"
  end

  create_table "web_users", force: true do |t|
    t.string   "ip"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
