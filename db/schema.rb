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

ActiveRecord::Schema.define(version: 20170527124439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",            null: false
    t.string   "permalink",       null: false
    t.integer  "parent_id"
    t.integer  "product_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "seller_id"
    t.string   "body"
    t.boolean  "accept",           default: false
    t.boolean  "accept_by_seller", default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "comments", ["product_id"], name: "index_comments_on_product_id", using: :btree
  add_index "comments", ["seller_id"], name: "index_comments_on_seller_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["product_id"], name: "index_favorites_on_product_id", using: :btree
  add_index "favorites", ["user_id", "product_id"], name: "index_favorites_on_user_id_and_product_id", unique: true, using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "layout",     default: true
    t.string   "title"
    t.string   "permalink"
    t.integer  "viewer"
    t.text     "content"
    t.string   "tags"
    t.boolean  "comment",    default: false
    t.boolean  "lock",       default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "product_fields", force: :cascade do |t|
    t.string   "name",                            null: false
    t.boolean  "required",        default: false
    t.string   "permalink",                       null: false
    t.integer  "position",        default: 0,     null: false
    t.integer  "product_type_id"
    t.string   "field_type"
    t.text     "categories",      default: [],                 array: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "product_fields", ["product_type_id"], name: "index_product_fields_on_product_type_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.boolean  "lock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                                 null: false
    t.integer  "category_id"
    t.string   "price"
    t.string   "off_price"
    t.integer  "position"
    t.boolean  "comment",         default: true
    t.boolean  "accept",          default: false
    t.integer  "view_product",    default: 0
    t.integer  "product_type_id"
    t.text     "properties",      default: "--- {}\n"
    t.text     "hstore",          default: "--- {}\n"
    t.string   "images"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "site_name",                default: "Agorna", null: false
    t.string   "seo_description",                             null: false
    t.string   "seo_keywords",                                null: false
    t.string   "site_logo"
    t.string   "default_image_product"
    t.string   "default_image_exposition"
    t.text     "style"
    t.text     "javascript"
    t.boolean  "site_down",                default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "ticketmessages", force: :cascade do |t|
    t.text     "message"
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.string   "file"
    t.boolean  "seen",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "user_two"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "marketer_id"
    t.integer  "level",                  default: 0,     null: false
    t.string   "name",                                   null: false
    t.string   "phone"
    t.boolean  "exposition",             default: false
    t.string   "exposition_name"
    t.string   "exposition_address"
    t.string   "exposition_detail"
    t.integer  "category_id"
    t.string   "static_phone"
    t.string   "avatar"
    t.string   "background_image"
    t.string   "instagram"
    t.string   "telegram"
    t.boolean  "post_service",           default: false
    t.boolean  "exposition_accept",      default: false
    t.string   "national_code",          default: ""
    t.string   "authentication_token",                   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "product_fields", "product_types"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "users"
end
