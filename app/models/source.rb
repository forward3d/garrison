class Source < ApplicationRecord

  has_many :alerts

  validates :name, presence: true

end
