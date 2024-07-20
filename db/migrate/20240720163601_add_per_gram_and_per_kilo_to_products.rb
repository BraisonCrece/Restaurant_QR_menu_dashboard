class AddPerGramAndPerKiloToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :per_gram, :boolean, precision: 10, scale: 2, default: false
    add_column :products, :per_kilo, :boolean, precision: 10, scale: 2, default: false
  end
end
