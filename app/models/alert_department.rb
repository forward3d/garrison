class AlertDepartment < ApplicationRecord

  include Discard::Model

  belongs_to :alert
  belongs_to :department

  validates :alert, presence: true
  validates :department, presence: true

end
