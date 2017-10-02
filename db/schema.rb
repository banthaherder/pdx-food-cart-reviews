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

ActiveRecord::Schema.define(version: 20171002173013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.string "tag"
    t.string "gp_id"
    t.boolean "is_confirmed"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "user_id"
    t.string "food_name"
    t.string "price"
    t.integer "rating"
    t.integer "reported_count"
    t.string "review"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "pass"
    t.string "email"
    t.boolean "is_confirmed"
    t.boolean "is_admin"
  end

end
