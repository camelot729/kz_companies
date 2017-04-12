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

ActiveRecord::Schema.define(version: 20170412190533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kz_companies", force: :cascade do |t|
    t.string   "bin_code"
    t.string   "okpo_code"
    t.string   "full_name_of_the_organization"
    t.string   "date_of_organization"
    t.integer  "main_oked"
    t.string   "name_of_main_activity"
    t.string   "secondary_oked"
    t.integer  "krp_code"
    t.string   "krp_name"
    t.string   "kato_code"
    t.string   "name_of_locality"
    t.string   "legal_address"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "full_name"
  end

end
