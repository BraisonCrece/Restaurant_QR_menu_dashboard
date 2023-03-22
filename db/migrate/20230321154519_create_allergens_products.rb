class CreateAllergensProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :allergens_products do |t|
      t.references :allergen, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
