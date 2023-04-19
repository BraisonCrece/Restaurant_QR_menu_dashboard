class Product < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :allergens, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  def self.categorized_products
    all.where(active: true).order(title: :asc).group_by(&:category_id)
  end

  # Image procesing before attach
  def process_image(file)
    processed_image = ImageProcessing::Vips
      .source(file)
      .resize_to_fill(1024, 512)
      .call

    self.picture.attach(io: File.open(processed_image.path), filename: "processed_#{file.original_filename}", content_type: "image/jpeg")
  end

end

