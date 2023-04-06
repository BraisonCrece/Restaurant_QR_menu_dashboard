class AddActiveToWines < ActiveRecord::Migration[7.0]
  def change
    add_column :wines, :active, :boolean, default: true
  end
end
