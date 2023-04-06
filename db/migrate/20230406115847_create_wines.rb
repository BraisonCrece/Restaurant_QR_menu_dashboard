class CreateWines < ActiveRecord::Migration[7.0]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :wine_type
      t.text :description
      t.decimal :price
      t.references :wine_origin_denomination, null: false, foreign_key: true

      t.timestamps
    end
  end
end
