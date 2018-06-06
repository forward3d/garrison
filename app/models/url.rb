class Url < ApplicationRecord

  include Discard::Model

  belongs_to :alert

  validates :alert, presence: true
  validates :url, presence: true

end
