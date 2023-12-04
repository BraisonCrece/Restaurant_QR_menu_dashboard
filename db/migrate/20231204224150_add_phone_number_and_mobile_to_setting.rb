class AddPhoneNumberAndMobileToSetting < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :phone_number, :string, default: '986 07 16 61'
    add_column :settings, :mobile, :string, default: '635 44 00 68'
  end
end
