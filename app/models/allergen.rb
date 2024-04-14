class Allergen < ApplicationRecord
  has_and_belongs_to_many :products, dependent: :destroy
  has_one_attached :icon, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [80, 80]
  end

  validates :name, :icon, presence: true
end
