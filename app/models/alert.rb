class Alert < ApplicationRecord

  belongs_to :kind
  belongs_to :family
  belongs_to :source

  belongs_to :severity_internal, class_name: 'Severity'
  belongs_to :severity_external, class_name: 'Severity'

  has_many :alert_departments
  has_many :alert_users

  has_many :departments, through: :alert_departments
  has_many :users, through: :alert_users

  has_many :urls
  has_many :key_values

end
