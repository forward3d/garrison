class Api::V1::AgentSerializer < ActiveModel::Serializer

  belongs_to :source
  has_many :runs

  attributes :id, :source, :check

  class SourceSerializer < ActiveModel::Serializer
    attributes :id, :name, :icon
  end

end
