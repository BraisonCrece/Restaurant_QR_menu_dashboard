class Allergen < ApplicationRecord
  has_and_belongs_to_many :products, dependent: :destroy
  has_one_attached :icon, dependent: :destroy

  validates :name, :icon, presence: true
end
