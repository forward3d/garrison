class KeyValue < ApplicationRecord

  include Discard::Model

  belongs_to :alert

  validates :alert, presence: true
  validates :key, presence: true

end
