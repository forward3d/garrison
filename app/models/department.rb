class Department < ApplicationRecord

  has_many :alerts, through: :alert_departments

  validates :name, presence: true

end
