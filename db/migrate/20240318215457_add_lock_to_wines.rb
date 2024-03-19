class AddLockToWines < ActiveRecord::Migration[7.0]
  def change
    add_column :wines, :lock, :boolean, default: false
  end
end
