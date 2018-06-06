class Severity < ApplicationRecord

  include Discard::Model

  has_many :alerts, ->(severity) { unscope(:where).where("severity_internal_id = :id OR severity_external_id = :id", id: severity.id) }

  validates :name, presence: true
  validates :order, presence: true
  validates :color, presence: true

end
