class Source < ApplicationRecord

  include Discard::Model
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :alerts

  validates :name, presence: true

  before_validation :set_name_from_slug_if_blank

  private

  def set_name_from_slug_if_blank
    self.name = slug if name.blank? && !slug.blank?
  end

end
