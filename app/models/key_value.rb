class KeyValue < ApplicationRecord

  belongs_to :alert

  validates :alert, presence: true
  validates :key, presence: true

end
