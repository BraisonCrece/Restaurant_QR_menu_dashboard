class CreateSpecialMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :special_menus do |t|
      t.string :name
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end
