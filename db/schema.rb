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

ActiveRecord::Schema.define(version: 20171207194946) do

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
  end

  create_table "bookable_types", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bookables", force: :cascade do |t|
    t.date     "date_start"
    t.string   "time_start"
    t.string   "time_start_unit"
    t.string   "time_finish"
    t.string   "time_finish_unit"
    t.integer  "bookable_type_id"
    t.integer  "location_id"
    t.integer  "instructor_id"
    t.decimal  "price"
    t.boolean  "pay_cash"
    t.boolean  "pay_online"
    t.boolean  "pay_points"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "attendee_count"
    t.boolean  "reconciled"
    t.string   "occurence"
    t.text     "recurring"
    t.datetime "start_time"
    t.index ["bookable_type_id"], name: "index_bookables_on_bookable_type_id"
    t.index ["instructor_id"], name: "index_bookables_on_instructor_id"
    t.index ["location_id"], name: "index_bookables_on_location_id"
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bookable_id"
    t.string   "stripe_id"
    t.string   "amount"
    t.string   "card_brand"
    t.string   "card_last4"
    t.string   "card_exp_month"
    t.string   "card_exp_year"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "failure_code"
    t.string   "failure_message"
    t.string   "status"
    t.boolean  "points"
    t.integer  "points_paid_with"
    t.decimal  "left_to_pay"
    t.string   "left_to_pay_method"
    t.integer  "package_id"
    t.boolean  "online_payment"
    t.boolean  "points_cash_payment"
    t.boolean  "points_online_payment"
    t.boolean  "cash_payment"
    t.boolean  "eftpos_payment"
    t.boolean  "debt_payment"
    t.boolean  "packages_payment"
    t.integer  "bookable_type_id"
    t.index ["bookable_id"], name: "index_charges_on_bookable_id"
    t.index ["bookable_type_id"], name: "index_charges_on_bookable_type_id"
    t.index ["package_id"], name: "index_charges_on_package_id"
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "debts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bookable_id"
    t.integer  "participant_id"
    t.decimal  "amount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["bookable_id"], name: "index_debts_on_bookable_id"
    t.index ["participant_id"], name: "index_debts_on_participant_id"
    t.index ["user_id"], name: "index_debts_on_user_id"
  end

  create_table "enquries", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instructors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "dob"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "phone"
    t.string   "phone2"
    t.string   "email"
    t.text     "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "state"
    t.string   "country"
    t.string   "phone_number"
    t.string   "email_address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "time_monday"
    t.string   "time_tuesday"
    t.string   "time_wednesday"
    t.string   "time_thursday"
    t.string   "time_friday"
    t.string   "time_saturday"
    t.string   "time_sunday"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "packages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price"
    t.boolean  "subscription"
    t.integer  "subscription_interval_count"
    t.string   "subscription_interval"
    t.string   "stripe_subscription_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "number_of_points"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "bookable_id"
    t.integer  "user_id"
    t.integer  "charge_id"
    t.boolean  "checked_in"
    t.string   "payment_method"
    t.string   "payment_status"
    t.boolean  "cancelled"
    t.text     "cancellation_reason"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "closed"
    t.boolean  "reconciled"
    t.index ["bookable_id"], name: "index_participants_on_bookable_id"
    t.index ["charge_id"], name: "index_participants_on_charge_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "number_of_points"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_points_on_user_id"
  end

  create_table "qualifications", force: :cascade do |t|
    t.string   "title"
    t.integer  "instructor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instructor_id"], name: "index_qualifications_on_instructor_id"
  end

  create_table "user_packages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_user_packages_on_package_id"
    t.index ["user_id"], name: "index_user_packages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stripe_customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "address"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zipcode"
    t.boolean  "pay_online_only"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "waiting_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "bookable_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bookable_id"], name: "index_waiting_lists_on_bookable_id"
    t.index ["user_id"], name: "index_waiting_lists_on_user_id"
  end

  create_table "walkins", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "become_regular"
    t.integer  "user_id"
  end

end
