class User < ApplicationRecord

  has_many :alerts, through: :alert_users

  validates :name, presence: true

end
