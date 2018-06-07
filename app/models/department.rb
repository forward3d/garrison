class Department < ApplicationRecord

  include Discard::Model
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :alerts, through: :alert_departments

  validates :name, presence: true

end
