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

ActiveRecord::Schema.define(version: 20161120232804) do

  create_table "cars", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "cars", ["user_id"], name: "index_cars_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "titulo",      limit: 255
    t.text     "descripcion", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "categories", ["titulo"], name: "index_categories_on_titulo", unique: true, using: :btree

  create_table "categorization", id: false, force: :cascade do |t|
    t.integer "product_id",  limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "categorization", ["category_id"], name: "index_categorization_on_category_id", using: :btree
  add_index "categorization", ["product_id", "category_id"], name: "index_categorization_on_product_id_and_category_id", unique: true, using: :btree
  add_index "categorization", ["product_id"], name: "index_categorization_on_product_id", using: :btree

  create_table "lines", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "car_id",     limit: 4
    t.integer  "cantidad",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "lines", ["car_id"], name: "index_lines_on_car_id", using: :btree
  add_index "lines", ["product_id"], name: "index_lines_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "titulo",      limit: 255
    t.text     "descripcion", limit: 65535
    t.string   "imagen",      limit: 255
    t.decimal  "precio",                    precision: 38, scale: 8
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "products", ["titulo"], name: "index_products_on_titulo", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "login",           limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "password_digest", limit: 255
    t.string   "direccion",       limit: 255
    t.integer  "edad",            limit: 4
    t.string   "cuenta_bancaria", limit: 255
    t.string   "remember_token",  limit: 255
    t.boolean  "admin",                       default: false, null: false
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "cars", "users"
  add_foreign_key "lines", "cars"
  add_foreign_key "lines", "products"
end
