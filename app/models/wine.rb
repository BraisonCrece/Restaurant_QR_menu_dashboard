class Wine < ApplicationRecord
  belongs_to :wine_origin_denomination
  has_one_attached :image
  validates :price_per_glass, numericality: { greater_than: 0 }, allow_nil: true
end
