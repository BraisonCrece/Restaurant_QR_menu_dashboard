class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.boolean :use_menu_path, default: false

      t.timestamps
    end
  end
end
