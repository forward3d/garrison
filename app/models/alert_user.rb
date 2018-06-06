class AlertUser < ApplicationRecord

  belongs_to :alert
  belongs_to :user

  validates :alert, presence: true
  validates :user, presence: true

end
