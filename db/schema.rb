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

ActiveRecord::Schema[7.0].define(version: 2022_08_03_112437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.datetime "arrived_at"
    t.datetime "left_at"
    t.string "name"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.integer "visits"
  end

  create_table "logs", force: :cascade do |t|
    t.string "client"
    t.decimal "temperature", precision: 4, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "latitude"
    t.string "longitude"
    t.decimal "humidity"
    t.integer "satellites"
    t.decimal "altitude"
    t.decimal "speed"
    t.string "connected_wifi"
    t.string "address"
    t.string "country"
    t.float "distance"
    t.boolean "motion"
    t.float "corrected_speed"
    t.float "corrected_distance"
  end

  create_table "trips", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer "days_in_motion"
    t.float "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
