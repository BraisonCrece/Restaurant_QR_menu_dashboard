class AddTypeToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :category_type, :string
  end
end
