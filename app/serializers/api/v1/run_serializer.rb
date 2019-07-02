class Api::V1::RunSerializer < ActiveModel::Serializer

  belongs_to :agent

  attributes :id, :started_at, :ended_at, :state

end
