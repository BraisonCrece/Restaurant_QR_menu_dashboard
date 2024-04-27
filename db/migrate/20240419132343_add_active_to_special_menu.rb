class AddActiveToSpecialMenu < ActiveRecord::Migration[7.0]
  def change
    add_column :special_menus, :active, :boolean, default: false
  end
end
