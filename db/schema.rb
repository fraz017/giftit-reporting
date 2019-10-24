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

ActiveRecord::Schema.define(version: 2019_10_23_125044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "giftcards", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.integer "giftcard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.string "hashid"
  end

  create_table "mcard_codes", id: :serial, force: :cascade do |t|
    t.string "title"
    t.float "balance"
    t.integer "reciever_id"
    t.integer "sender_id"
    t.integer "mcard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hashid"
    t.datetime "recieved_at"
    t.datetime "sent_at"
    t.string "machine_id"
    t.boolean "sandbox", default: false
    t.string "url"
    t.string "email"
    t.string "card_type", default: "system"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "creator_email"
    t.integer "image_id"
    t.index ["image_id"], name: "index_mcard_codes_on_image_id"
    t.index ["mcard_id"], name: "index_mcard_codes_on_mcard_id"
    t.index ["reciever_id"], name: "index_mcard_codes_on_reciever_id"
    t.index ["sender_id"], name: "index_mcard_codes_on_sender_id"
  end

  create_table "mcards", id: :serial, force: :cascade do |t|
    t.string "title"
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mcards_sub_admins", id: false, force: :cascade do |t|
    t.integer "sub_admin_id", null: false
    t.integer "mcard_id", null: false
    t.index ["mcard_id", "sub_admin_id"], name: "index_mcards_sub_admins_on_mcard_id_and_sub_admin_id"
    t.index ["sub_admin_id", "mcard_id"], name: "index_mcards_sub_admins_on_sub_admin_id_and_mcard_id"
  end

  create_table "media", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "mcard_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_file_name"
    t.string "video_content_type"
    t.integer "video_file_size"
    t.datetime "video_updated_at"
    t.index ["mcard_code_id"], name: "index_media_on_mcard_code_id"
    t.index ["user_id"], name: "index_media_on_user_id"
  end

  create_table "push_notifications", id: :serial, force: :cascade do |t|
    t.string "device_token"
    t.integer "testing_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "platform", default: "ios"
    t.index ["user_id"], name: "index_push_notifications_on_user_id"
  end

  create_table "stores", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.float "radius"
    t.string "street1"
    t.string "street2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_admins", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "phone", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_sub_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sub_admins_on_reset_password_token", unique: true
  end

  create_table "super_users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_super_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_super_users_on_reset_password_token", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "username"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "platform"
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

end
