class Kind < ApplicationRecord

  include Discard::Model

  has_many :alerts

  validates :name, presence: true

end
