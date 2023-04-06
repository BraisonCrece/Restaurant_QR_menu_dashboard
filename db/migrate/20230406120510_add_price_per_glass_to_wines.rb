class AddPricePerGlassToWines < ActiveRecord::Migration[7.0]
  def change
    add_column :wines, :price_per_glass, :decimal
  end
end
