class AddRootPageToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :root_page, :string, default: "index"
  end
end
