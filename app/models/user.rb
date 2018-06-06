class User < ApplicationRecord

  include Discard::Model

  has_many :alerts, through: :alert_users

  validates :name, presence: true

end
