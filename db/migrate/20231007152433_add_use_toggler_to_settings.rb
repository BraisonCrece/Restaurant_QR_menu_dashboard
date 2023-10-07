class AddUseTogglerToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :show_toggler, :boolean, default: true
  end
end
