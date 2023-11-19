class Setting < ApplicationRecord
  def self.use_menu_path?
    init_settings unless first
    first.use_menu_path
  end

  def self.show_toggler?
    init_settings unless first
    first.show_toggler
  end

  def self.root_page
    init_settings unless first
    first.root_page
  end

  private

  def self.init_settings
    create(root_page: nil, show_toggler: true, use_menu_path: false)
  end
end

