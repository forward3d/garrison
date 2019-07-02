class Agent < ApplicationRecord

  include Discard::Model

  belongs_to :source

  has_many :runs
  has_many :alerts

  validates :check, presence: true
  validates :source, presence: true

end
