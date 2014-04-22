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

ActiveRecord::Schema.define(version: 20140422163057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: true do |t|
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "phone1"
    t.string "phone2"
    t.string "email"
  end

  create_table "rates", force: true do |t|
    t.integer "reservation_item_id"
    t.date    "date"
    t.float   "amount"
  end

  create_table "rental_items", force: true do |t|
    t.string  "name"
    t.integer "rental_type_id"
    t.string  "bed_config"
    t.string  "status"
  end

  create_table "rental_types", force: true do |t|
    t.string  "category"
    t.string  "subcategory"
    t.integer "max_occupancy"
    t.string  "description"
    t.string  "image_filename"
    t.string  "image_alt"
    t.integer "num_bedrooms"
    t.integer "num_baths"
    t.integer "length"
    t.integer "width"
    t.integer "height"
    t.float   "weekday_rate"
    t.float   "weekend_rate"
    t.float   "monthly_rate"
  end

  create_table "reservation_items", force: true do |t|
    t.string  "status"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "num_of_days"
    t.integer "adults"
    t.integer "children"
    t.integer "pets"
    t.integer "reservation_id"
    t.integer "rental_item_id"
  end

  create_table "reservations", force: true do |t|
    t.string  "status"
    t.integer "customer_id"
  end

  create_table "u_s_states", force: true do |t|
    t.string "abbreviation"
    t.string "name"
  end

end
