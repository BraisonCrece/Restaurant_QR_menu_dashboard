# frozen_string_literal: true

# Controller for the SpecialMenus model
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

  def new_product
    @product = Product.new
    @special_menu = SpecialMenu.find(params[:special_menu_id])
  end

  def create_product
    @product = Product.new(product_params)
    @product.active = false
    @product.lock_it!

    Thread.new do
      Translators::ProcessTranslationsService.new(@product, :create).call
    end

    @product.process_image(params[:product][:picture]) if params[:product][:picture]

    if @product.save
      redirect_to special_menus_path, notice: 'Plato engadido ao menú especial con éxito.'
    else
      render :new_product, alert: 'Erro ao engadir o plato ao menú especial.'
    end
  end

  def edit_product
    @product = Product.find(params[:product_id])
    @special_menu = SpecialMenu.find(params[:special_menu_id])
  end

  def update_product
    @product = Product.find(params[:product_id])

    if @product.update(product_params)
      if title_or_description_changed?
        Thread.new do
          Translators::ProcessTranslationsService.new(@product, :update).call
        end
      end

      @product.process_image(params[:product][:picture]) if params[:product][:picture]

      redirect_to special_menus_path, notice: 'Plato actualizado con éxito.'
    else
      render :edit_product, status: :unprocessable_entity, alert: 'Erro ao actualizar o plato.'
    end
  end

  def destroy_product
    @product = Product.find(params[:product_id])
    @product.destroy

    Thread.new do
      Translators::ProcessTranslationsService.new(@product, :destroy).call
    end

    redirect_to special_menus_path, status: 303, notice: 'Plato eliminado con éxito.'
  end

  private

  def special_menu_params
    params.require(:special_menu).permit(:name, :description, :price)
  end

  def product_params
    params.require(:product).permit(
      :title, :description, :price, :picture, :special_menu_id,
      :per_gram, :per_kilo, :per_unit, allergen_ids: []
    )
  end

  def title_or_description_changed?
    @product.previous_changes.include?('title') || @product.previous_changes.include?('description')
  end
end
