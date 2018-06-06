class AlertDepartment < ApplicationRecord

  belongs_to :alert
  belongs_to :department

end
