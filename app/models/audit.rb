class Audit < ApplicationRecord

  belongs_to :alert

  validates :alert,   presence: true
  validates :kind,    presence: true
  validates :action,  presence: true
  # validates :author,  presence: true

end
