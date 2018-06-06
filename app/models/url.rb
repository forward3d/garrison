class Url < ApplicationRecord

  belongs_to :alert

  validates :alert, presence: true
  validates :url, presence: true

end
