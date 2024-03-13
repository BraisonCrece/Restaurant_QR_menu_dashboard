class Wine < ApplicationRecord
  broadcasts_refreshes

  belongs_to :wine_origin_denomination
  has_one_attached :image
  validates :price_per_glass, numericality: { greater_than: 0 }, allow_nil: true

  def self.categorized_wines(denominations, available_colors)
    wines_by_color_and_denomination = {}
    available_colors.each do |color|
      wines_by_color_and_denomination[color] = {}
      denominations.each do |denomination|
        wines = denomination.wines.where(active: true, wine_type: color).order(name: :asc)
        wines_by_color_and_denomination[color][denomination.id] = wines unless wines.blank?
      end
    end
    wines_by_color_and_denomination
  end

  # Image procesing before attach, allowed formats [:jpg, :png]
  def process_wine(file)
    ImageProcessingService.new(file:, record: self, attachment_name: :image, wine: true).call
  end
end
