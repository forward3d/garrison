class Source < ApplicationRecord

  include Discard::Model
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :alerts

  validates :name, presence: true

end
