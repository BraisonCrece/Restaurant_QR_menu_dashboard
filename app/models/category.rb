class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  scope :menu, -> { where(category_type: 'menu').order(created_at: :asc) }
  scope :daily, -> { where(category_type: 'daily').order(created_at: :asc) }
end
