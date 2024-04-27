class SpecialMenusController < ApplicationController
  def index
    @special_menus = SpecialMenu.all
  end

  def new
    @special_menu = SpecialMenu.new
  end

  def create
    @special_menu = SpecialMenu.new(special_menu_params)
    if @special_menu.save
      redirect_to special_menus_path, notice: 'Menú especial creado con éxito.'
    else
      render :new, alert: 'Erro ao crear o menú especial.'
    end
  end

  def edit
    @special_menu = SpecialMenu.find(params[:id])
  end

  def update
    @special_menu = SpecialMenu.find(params[:id])
    if @special_menu.update(special_menu_params)
      redirect_to special_menus_path, notice: 'Menú especial actualizado con éxito.'
    else
      render :edit, alert: 'Erro ao actualizar o menú especial.'
    end
  end

  def destroy
    @special_menu = SpecialMenu.find(params[:id])
    @special_menu.destroy
    redirect_to special_menus_path, notice: 'Menú especial eliminado con éxito.'
  end

  def toggle_active
    @special_menu = SpecialMenu.find(params[:special_menu_id])
    @special_menu.toggle(:active)
    @special_menu.save
    render turbo_stream: turbo_stream.replace("special_menu_active_#{@special_menu.id}",
      partial: 'special_menus/active',
      locals: { special_menu: @special_menu })
  end

  private

  def special_menu_params
    params.require(:special_menu).permit(:name, :description, :price)
  end
end
