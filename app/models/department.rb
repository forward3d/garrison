class Department < ApplicationRecord

  include Discard::Model

  has_many :alerts, through: :alert_departments

  validates :name, presence: true

end
