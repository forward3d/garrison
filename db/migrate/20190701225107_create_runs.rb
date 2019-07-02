class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs, id: :uuid do |t|
      t.references :agent, null: false, type: :uuid, foreign_key: true
      t.string :state, index: true
      t.datetime :started_at, index: true
      t.datetime :ended_at, index: true
      t.datetime :discarded_at, index: true
      t.timestamps
    end
  end
end
