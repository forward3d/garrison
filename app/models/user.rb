class User < ApplicationRecord

  include Discard::Model
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :alerts, through: :alert_users

  validates :name, presence: true

end
