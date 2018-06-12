class CreateBase < ActiveRecord::Migration[5.2]
  def change
    enable_extension "pgcrypto"

    create_table :kinds, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :icon
      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :families, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :icon
      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :sources, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :icon
      t.datetime :last_seen_at
      t.datetime :last_alert_at
      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :severities, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.integer :order, index: true, null: false
      t.string :color
      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :departments, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :users, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.datetime :discarded_at, index: true
      t.timestamps
    end

    create_table :alerts, id: :uuid do |t|
      t.string :state, null: false
      t.references :kind, null: false, type: :uuid, foreign_key: true
      t.references :family, null: false, type: :uuid, foreign_key: true
      t.references :source, null: false, type: :uuid, foreign_key: true
      t.integer :count, default: 1
      t.string :name, null: false
      t.string :target
      t.string :detail
      t.uuid :severity_external_id, index: true
      t.uuid :severity_internal_id, index: true
      t.string :ticket
      t.text :notes
      t.json :finding, null: false
      t.string :finding_id
      t.datetime :first_detected_at
      t.datetime :last_detected_at
      t.datetime :assigned_at
      t.datetime :verified_at
      t.datetime :resolved_at
      t.datetime :rejected_at
      t.datetime :discarded_at, index: true
      t.timestamps
    end
    add_foreign_key :alerts, :severities, column: :severity_external_id
    add_foreign_key :alerts, :severities, column: :severity_internal_id

    create_table :alert_departments, id: :uuid do |t|
      t.references :alert, null: false, type: :uuid
      t.references :department, null: false, type: :uuid
      t.datetime :discarded_at, index: true
      t.timestamps
    end
    add_foreign_key :alert_departments, :alerts
    add_foreign_key :alert_departments, :departments

    create_table :alert_users, id: :uuid do |t|
      t.references :alert, null: false, type: :uuid
      t.references :user, null: false, type: :uuid
      t.datetime :discarded_at, index: true
      t.timestamps
    end
    add_foreign_key :alert_users, :alerts
    add_foreign_key :alert_users, :users

    create_table :urls, id: :uuid do |t|
      t.references :alert, null: false, type: :uuid
      t.string :name
      t.string :url, null: false
      t.datetime :discarded_at, index: true
      t.timestamps
    end
    add_foreign_key :urls, :alerts

    create_table :key_values, id: :uuid do |t|
      t.references :alert, null: false, type: :uuid
      t.string :key, null: false
      t.string :value
      t.datetime :discarded_at, index: true
      t.timestamps
    end
    add_foreign_key :key_values, :alerts

    create_table :audits, id: :uuid do |t|
      t.references :alert, null: false, type: :uuid
      t.string :icon
      t.string :kind, null: false
      t.string :action, null: false
      t.string :author
      t.timestamps
    end
    add_foreign_key :audits, :alerts
  end
end
