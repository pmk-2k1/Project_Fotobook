# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_26_085226) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "description"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "follow_users", force: :cascade do |t|
    t.bigint "following_id"
    t.bigint "follower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_follow_users_on_follower_id"
    t.index ["following_id"], name: "index_follow_users_on_following_id"
  end

  create_table "like_posts", force: :cascade do |t|
    t.string "interact_type"
    t.bigint "interact_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interact_type", "interact_id"], name: "index_like_posts_on_interact"
    t.index ["user_id"], name: "index_like_posts_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "album_id"
    t.string "title"
    t.string "description"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["album_id"], name: "index_photos_on_album_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "password"
    t.text "email"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "albums", "users"
  add_foreign_key "follow_users", "users", column: "follower_id"
  add_foreign_key "follow_users", "users", column: "following_id"
  add_foreign_key "like_posts", "users"
  add_foreign_key "photos", "albums"
  add_foreign_key "photos", "users"
end
