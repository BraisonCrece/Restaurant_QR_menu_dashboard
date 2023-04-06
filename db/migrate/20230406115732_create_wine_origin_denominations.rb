class CreateWineOriginDenominations < ActiveRecord::Migration[7.0]
  def change
    create_table :wine_origin_denominations do |t|
      t.string :name

      t.timestamps
    end
  end
end
