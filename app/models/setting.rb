class Setting < ApplicationRecord
  def self.use_menu_path?
    create(use_menu_path: false, show_toggler: true, root_page: "index") unless first
    first.use_menu_path
  end

  def self.show_toggler?
    create(use_menu_path: false, show_toggler: true, root_page: "index") unless first
    first.show_toggler
  end

  def self.root_page
    "menu"
    # create(root_page: "index", show_toggler: true, use_menu_path: false) unless first
    # first.root_page
  end
end

