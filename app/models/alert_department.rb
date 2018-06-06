class AlertDepartment < ApplicationRecord

  belongs_to :alert
  belongs_to :department

  validates :alert, presence: true
  validates :department, presence: true

end
