class AddAgentUuidToAlert < ActiveRecord::Migration[5.2]
  def change
    add_column :alerts, :agent_uuid, :uuid, after: :source
    add_index :alerts, :agent_uuid

    add_column :alerts, :agent_run_uuid, :uuid, after: :agent_uuid
    add_index :alerts, :agent_run_uuid

    add_column :alerts, :obsoleted_at, :datetime
    add_index :alerts, :obsoleted_at
  end
end
