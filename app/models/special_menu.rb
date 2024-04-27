class SpecialMenu < ApplicationRecord
  broadcasts_refreshes

  has_many :products

  scope :active, -> { where(active: true) }
  scope :active_products, -> { products.where(active: true) }
end
