# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index menu show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[index new edit]

  WINE_COLORS = %w[Blanco Tinto].freeze

  def index
    @categorized_products = Product.categorized_products
    @special_menus = SpecialMenu.active
    @categories = Category.menu
    @denominations = WineOriginDenomination.all.includes(:wines)
    @categorized_wines = Wine.categorized_wines(@denominations, WINE_COLORS)
  end

  def menu
    @categorized_products = Product.menu_categorized_products
    @menu_categories = Category.daily
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.active = false
    @product.lock_it!

    Thread.new do
      Translators::ProcessTranslationsService.new(@product, :create).call
    end

    @product.process_image(params[:product][:picture]) if params[:product][:picture]

    if @product.save
      flash[:notice] = 'Producto engadido! Será automáticamente activado cando as traduccións rematen.'
      redirect_to control_panel_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)

      if title_or_description_changed?
        Thread.new do
          Translators::ProcessTranslationsService.new(@product, :update).call
        end
      end

      @product.process_image(params[:product][:picture]) if params[:product][:picture]
      redirect_to control_panel_path, notice: 'Producto editado con éxito'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    Thread.new do
      Translators::ProcessTranslationsService.new(@product, :destroy).call
    end

    redirect_to control_panel_path, status: 303, notice: 'Producto eliminado!'
  end

  def control_panel
    @products, @color = set_products_and_color_based_on_params
  end

  def pages_control
    @settings = Setting.first
  end

  def toggle_active
    product = Product.find(params[:product_id])
    product.update(active: !product.active)

    render turbo_stream: turbo_replace_product(product)
  end

  private

  def turbo_replace_product(product)
    turbo_stream
      .replace(
        "product_active_#{product.id}",
        partial: 'products/active',
        locals: { product: }
      )
  end

  def title_or_description_changed?
    @product.previous_changes.include?('title') || @product.previous_changes.include?('description')
  end

  def set_products_and_color_based_on_params
    case params[:filter]
    when 'menu'
      [Product.not_daily_menu, { carta: 'oscuro', menu: 'clarito' }]
    else
      [Product.daily_menu, { carta: 'clarito', menu: 'oscuro' }]
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(
      :title, :description, :prize, :category_id, :special_menu_id,
      :picture, :per_gram, :per_kilo, :per_unit, allergen_ids: []
    )
  end
end
