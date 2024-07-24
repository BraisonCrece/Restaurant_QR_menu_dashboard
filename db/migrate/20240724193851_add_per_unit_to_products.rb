class AddPerUnitToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :per_unit, :boolean, default: false
  end
end
