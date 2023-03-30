class ChangeDataTypeOfProductsPrize < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :prize, :float
  end
end
