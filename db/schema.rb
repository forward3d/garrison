# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_08_173928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "agents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "source_id", null: false
    t.string "check", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check"], name: "index_agents_on_check"
    t.index ["discarded_at"], name: "index_agents_on_discarded_at"
    t.index ["source_id"], name: "index_agents_on_source_id"
  end

  create_table "alert_departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "alert_id", null: false
    t.uuid "department_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alert_departments_on_alert_id"
    t.index ["department_id"], name: "index_alert_departments_on_department_id"
    t.index ["discarded_at"], name: "index_alert_departments_on_discarded_at"
  end

  create_table "alert_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "alert_id", null: false
    t.uuid "user_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_alert_users_on_alert_id"
    t.index ["discarded_at"], name: "index_alert_users_on_discarded_at"
    t.index ["user_id"], name: "index_alert_users_on_user_id"
  end

  create_table "alerts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "state", null: false
    t.uuid "kind_id", null: false
    t.uuid "family_id", null: false
    t.uuid "source_id", null: false
    t.integer "count", default: 1
    t.string "name", null: false
    t.string "target"
    t.string "detail"
    t.uuid "severity_external_id"
    t.uuid "severity_internal_id"
    t.string "ticket"
    t.text "notes"
    t.json "finding", null: false
    t.string "finding_id"
    t.datetime "first_detected_at"
    t.datetime "last_detected_at"
    t.datetime "assigned_at"
    t.datetime "verified_at"
    t.datetime "resolved_at"
    t.datetime "rejected_at"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "agent_id"
    t.uuid "run_id"
    t.datetime "obsoleted_at"
    t.index ["agent_id"], name: "index_alerts_on_agent_id"
    t.index ["discarded_at"], name: "index_alerts_on_discarded_at"
    t.index ["family_id"], name: "index_alerts_on_family_id"
    t.index ["kind_id"], name: "index_alerts_on_kind_id"
    t.index ["obsoleted_at"], name: "index_alerts_on_obsoleted_at"
    t.index ["run_id"], name: "index_alerts_on_run_id"
    t.index ["severity_external_id"], name: "index_alerts_on_severity_external_id"
    t.index ["severity_internal_id"], name: "index_alerts_on_severity_internal_id"
    t.index ["source_id"], name: "index_alerts_on_source_id"
  end

  create_table "audits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "alert_id", null: false
    t.string "icon"
    t.string "kind", null: false
    t.string "action", null: false
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_audits_on_alert_id"
  end

  create_table "departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_departments_on_discarded_at"
  end

  create_table "families", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.string "icon"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_families_on_discarded_at"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "key_values", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "alert_id", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_key_values_on_alert_id"
    t.index ["discarded_at"], name: "index_key_values_on_discarded_at"
  end

  create_table "kinds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.string "icon"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_kinds_on_discarded_at"
  end

  create_table "runs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "agent_id", null: false
    t.string "state"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_runs_on_agent_id"
    t.index ["discarded_at"], name: "index_runs_on_discarded_at"
    t.index ["ended_at"], name: "index_runs_on_ended_at"
    t.index ["started_at"], name: "index_runs_on_started_at"
    t.index ["state"], name: "index_runs_on_state"
  end

  create_table "severities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.integer "order", null: false
    t.string "color"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_severities_on_discarded_at"
    t.index ["order"], name: "index_severities_on_order"
  end

  create_table "sources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.string "icon"
    t.datetime "last_seen_at"
    t.datetime "last_alert_at"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_sources_on_discarded_at"
  end

  create_table "urls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "alert_id", null: false
    t.string "name"
    t.string "url", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_urls_on_alert_id"
    t.index ["discarded_at"], name: "index_urls_on_discarded_at"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
  end

  add_foreign_key "agents", "sources"
  add_foreign_key "alert_departments", "alerts"
  add_foreign_key "alert_departments", "departments"
  add_foreign_key "alert_users", "alerts"
  add_foreign_key "alert_users", "users"
  add_foreign_key "alerts", "agents"
  add_foreign_key "alerts", "families"
  add_foreign_key "alerts", "kinds"
  add_foreign_key "alerts", "runs"
  add_foreign_key "alerts", "severities", column: "severity_external_id"
  add_foreign_key "alerts", "severities", column: "severity_internal_id"
  add_foreign_key "alerts", "sources"
  add_foreign_key "audits", "alerts"
  add_foreign_key "key_values", "alerts"
  add_foreign_key "runs", "agents"
  add_foreign_key "urls", "alerts"
end
