class Setting < ApplicationRecord
  def self.use_menu_path?
    init_settings unless first
    first.use_menu_path
  end

  def self.show_toggler?
    init_settings unless first
    first.show_toggler
  end

  def self.show_locale_toggler?
    init_settings unless first
    first.locale_toggler
  end

  def self.root_page
    init_settings unless first
    first.root_page
  end

  def self.menu_price
    init_settings unless first
    first.menu_price
  end

  def self.phone_number
    init_settings unless first
    first.phone_number
  end

  def self.mobile
    init_settings unless first
    first.mobile
  end

  def self.init_settings
    create(
      root_page: nil,
      show_toggler: true,
      locale_toggler: false,
      use_menu_path: false,
      menu_price: 12.5,
      phone_number: '986 07 16 61',
      mobile: '635 44 00 68'
    )
  end
end
