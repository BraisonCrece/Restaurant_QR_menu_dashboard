class Product < ApplicationRecord
  broadcasts_refreshes

  belongs_to :category, optional: true
  has_and_belongs_to_many :allergens, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  validates :title, :description, presence: true
  validate :active_when_not_locked

  scope :categorized_products, lambda {
    where(active: true)
      .joins(:category)
      .where(categories: { category_type: 'menu' })
      .order(title: :asc)
      .group_by(&:category_id)
  }

  scope :menu_categorized_products, lambda {
    where(active: true)
      .joins(:category)
      .where(categories: { category_type: 'daily' })
      .order(title: :asc)
      .group_by(&:category_id)
  }

  def lock_it!
    update(lock: true)
  end

  def unlock_it!
    update(lock: false)
  end

  # Image procesing before attach, allowed formats [:jpg, :png]
  def process_image(file)
    ImageProcessingService.new(file:, record: self, attachment_name: :picture).call
  end

  private

  def active_when_not_locked
    errors.add(:active, 'is not allowed when product is locked') if lock? && active?
  end
end
