class Severity < ApplicationRecord

  has_many :alerts, ->(severity) { unscope(:where).where("severity_internal_id = :id OR severity_external_id = :id", id: severity.id) }

end
