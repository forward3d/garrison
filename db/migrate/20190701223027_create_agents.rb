class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents, id: :uuid do |t|
      t.references :source, null: false, type: :uuid, foreign_key: true
      t.string :check, null: false, index: true
      t.datetime :discarded_at, index: true
      t.timestamps
    end
  end
end
