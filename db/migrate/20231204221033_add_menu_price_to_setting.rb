class AddMenuPriceToSetting < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :menu_price, :decimal, default: 12.5
  end
end
