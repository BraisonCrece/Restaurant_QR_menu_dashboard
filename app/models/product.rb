class Product < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :allergens, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  validates :title, :description, :prize, presence: true

  scope :categorized_products, -> { where(active: true).order(title: :asc).group_by(&:category_id) }

  # Image procesing before attach, allowed formats [:jpg, :png]
  def process_image(file)
    ImageProcessingService.new(file: file, record: self, attachment_name: :picture).call
  end
end
