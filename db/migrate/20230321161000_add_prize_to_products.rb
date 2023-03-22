class AddPrizeToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :prize, :integer
  end
end
