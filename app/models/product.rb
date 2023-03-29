class Product < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :allergens, dependent: :destroy
  has_one_attached :picture, dependent: :destroy
end

