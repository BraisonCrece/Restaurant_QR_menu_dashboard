class AddLockToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :lock, :boolean, default: false
  end
end
