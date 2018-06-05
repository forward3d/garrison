class CreateBase < ActiveRecord::Migration[5.2]
  def change
    create_table :kinds do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :families do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :sources do |t|
      t.string :name, null: false
      t.string :icon
      t.datetime :last_seen_at
      t.datetime :last_alert_at
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :severities do |t|
      t.string :name, null: false
      t.integer :order, index: true, null: false
      t.string :color
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :departments do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :users do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :alerts do |t|
      t.string :state, null: false
      t.references :kind, null: false
      t.references :family, null: false
      t.references :source, null: false
      t.integer :count, default: 1
      t.string :name, null: false
      t.string :target
      t.string :detail
      t.bigint :severity_external, index: true
      t.bigint :severity_internal, index: true
      t.string :ticket
      t.text :notes
      t.json :finding, null: false
      t.string :finding_id
      t.datetime :first_detected_at
      t.datetime :last_detected_at
      t.datetime :assigned_at
      t.datetime :resolved_at
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :alerts, :kinds
    add_foreign_key :alerts, :families
    add_foreign_key :alerts, :sources
    add_foreign_key :alerts, :severities, column: :severity_external
    add_foreign_key :alerts, :severities, column: :severity_internal

    create_table :alert_departments do |t|
      t.references :alert, null: false
      t.references :department, null: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :alert_departments, :alerts
    add_foreign_key :alert_departments, :departments

    create_table :alert_users do |t|
      t.references :alert, null: false
      t.references :user, null: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :alert_users, :alerts
    add_foreign_key :alert_users, :users

    create_table :urls do |t|
      t.references :alert, null: false
      t.string :name
      t.string :url, null: false
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :urls, :alerts

    create_table :key_values do |t|
      t.references :alert, null: false
      t.string :key, null: false
      t.string :value
      t.datetime :deleted_at
      t.timestamps
    end
    add_foreign_key :key_values, :alerts

    create_table :audits do |t|
      t.references :alert, null: false
      t.string :icon
      t.string :kind, null: false
      t.string :action, null: false
      t.string :author, null: false
      t.timestamps
    end
    add_foreign_key :audits, :alerts
  end
end
