class Allergen < ApplicationRecord
  has_and_belongs_to_many :products
  has_one_attached :icon, dependent: :destroy
end
