class AddLocaleTogglerToSetting < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :locale_toggler, :boolean, default: false
  end
end
