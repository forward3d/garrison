class Run < ApplicationRecord

  include Discard::Model

  belongs_to :agent
  has_many :alerts

  validates :started_at, presence: true
  validates :state, presence: true

end
