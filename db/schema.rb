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

ActiveRecord::Schema.define(version: 2018_06_05_191539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_departments", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.bigint "department_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alert_departments_on_alert_id"
    t.index ["department_id"], name: "index_alert_departments_on_department_id"
  end

  create_table "alert_users", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.bigint "user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alert_users_on_alert_id"
    t.index ["user_id"], name: "index_alert_users_on_user_id"
  end

  create_table "alerts", force: :cascade do |t|
    t.string "state", null: false
    t.bigint "kind_id", null: false
    t.bigint "family_id", null: false
    t.bigint "source_id", null: false
    t.integer "count", default: 1
    t.string "name", null: false
    t.string "target"
    t.string "detail"
    t.bigint "severity_external"
    t.bigint "severity_internal"
    t.string "ticket"
    t.text "notes"
    t.json "finding", null: false
    t.string "finding_id"
    t.datetime "first_detected_at"
    t.datetime "last_detected_at"
    t.datetime "assigned_at"
    t.datetime "resolved_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_alerts_on_family_id"
    t.index ["kind_id"], name: "index_alerts_on_kind_id"
    t.index ["severity_external"], name: "index_alerts_on_severity_external"
    t.index ["severity_internal"], name: "index_alerts_on_severity_internal"
    t.index ["source_id"], name: "index_alerts_on_source_id"
  end

  create_table "audits", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.string "icon"
    t.string "kind", null: false
    t.string "action", null: false
    t.string "author", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_audits_on_alert_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "key_values", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_key_values_on_alert_id"
  end

  create_table "kinds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "severities", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order", null: false
    t.string "color"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order"], name: "index_severities_on_order"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name", null: false
    t.string "icon"
    t.datetime "last_seen_at"
    t.datetime "last_alert_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "urls", force: :cascade do |t|
    t.bigint "alert_id", null: false
    t.string "name"
    t.string "url", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_urls_on_alert_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "alert_departments", "alerts"
  add_foreign_key "alert_departments", "departments"
  add_foreign_key "alert_users", "alerts"
  add_foreign_key "alert_users", "users"
  add_foreign_key "alerts", "families"
  add_foreign_key "alerts", "kinds"
  add_foreign_key "alerts", "severities", column: "severity_external"
  add_foreign_key "alerts", "severities", column: "severity_internal"
  add_foreign_key "alerts", "sources"
  add_foreign_key "audits", "alerts"
  add_foreign_key "key_values", "alerts"
  add_foreign_key "urls", "alerts"
end
