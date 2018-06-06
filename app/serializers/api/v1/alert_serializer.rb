class Api::V1::AlertSerializer < ActiveModel::Serializer

  belongs_to :kind
  belongs_to :family
  belongs_to :source
  belongs_to :severity_internal, class_name: 'Severity'
  belongs_to :severity_external, class_name: 'Severity'

  has_many :urls
  has_many :departments
  has_many :users
  has_many :audits
  has_many :key_values

  attributes :id, :state, :count, :name, :target, :detail, :ticket, :notes, :finding, :finding_id, :first_detected_at, :last_detected_at, :assigned_at, :resolved_at, :created_at, :updated_at

  class AuditSerializer < ActiveModel::Serializer
    attributes :id, :icon, :kind, :action, :author, :created_at
  end

  class KeyValueSerializer < ActiveModel::Serializer
    attributes :id, :key, :value
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  class DepartmentSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  class SeveritySerializer < ActiveModel::Serializer
    attributes :id, :name, :order, :color
  end

  class KindSerializer < ActiveModel::Serializer
    attributes :id, :name, :icon
  end

  class FamilySerializer < ActiveModel::Serializer
    attributes :id, :name, :icon
  end

  class SourceSerializer < ActiveModel::Serializer
    attributes :id, :name, :icon
  end

  class UrlSerializer < ActiveModel::Serializer
    attributes :id, :name, :url
  end

end
