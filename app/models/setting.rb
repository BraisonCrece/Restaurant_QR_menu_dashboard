class Setting < ApplicationRecord
  def self.use_menu_path?
    create(use_menu_path: false, show_toggler: true) unless first
    first.use_menu_path
  end

  def self.show_toggler?
    create(use_menu_path: false, show_toggler: true) unless first
    first.show_toggler
  end
end

