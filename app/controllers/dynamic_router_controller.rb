class DynamicRouterController < ApplicationController
  def call
    if Setting.root_page == "menu"
      redirect_to menu_path
    else
      redirect_to carta_path
    end
  end
end
