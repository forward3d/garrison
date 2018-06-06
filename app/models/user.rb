class User < ApplicationRecord

  has_many :alerts, through: :alert_users

end
