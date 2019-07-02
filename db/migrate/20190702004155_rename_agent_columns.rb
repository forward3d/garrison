class RenameAgentColumns < ActiveRecord::Migration[5.2]
  def change

    Alert.where.not(agent_uuid: nil).each do |alert|
      Agent.find_or_create_by(id: alert.agent_uuid, source_id: alert.source_id, check: 'Unknown')
    end

    Alert.where.not(agent_uuid: nil, agent_run_uuid: nil).each do |alert|
      run = Run.find_or_initialize_by(id: alert.agent_run_uuid, agent_id: alert.agent_uuid)
      run.started_at = alert.created_at
      run.ended_at = alert.created_at
      run.state = 'completed'
      run.save!
    end

    rename_column :alerts, :agent_uuid, :agent_id
    rename_column :alerts, :agent_run_uuid, :run_id

    add_foreign_key :alerts, :agents
    add_foreign_key :alerts, :runs
  end
end
