class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index menu show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[index new edit]

  def index
    @categorized_products = Product.categorized_products
    @categories = Category.menu
    @denominations = WineOriginDenomination.all.includes(:wines)
    @available_colors = %w[Blanco Tinto].freeze
    @categorized_wines = Wine.categorized_wines(@denominations, @available_colors)
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
    @product.active = true

    @product.process_image(params[:product][:picture]) if params[:product][:picture]

    if @product.save
      flash[:notice] = 'Producto engadido!'
      render :new, status: :ok
      flash.clear
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
      @product.process_image(params[:product][:picture]) if params[:product][:picture]
      redirect_to control_panel_path, notice: 'Producto editado con éxito'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
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
    render turbo_stream: turbo_stream.replace("product_active_#{product.id}", partial: 'products/active',
                                                                              locals: { product: })
  end

  private

  def set_products_and_color_based_on_params
    case params[:filter]
    when 'menu'
      [
        Product.joins(:category).where(categories: { category_type: 'daily' }).order('products.active DESC'),
        { carta: 'clarito', menu: 'oscuro' }
      ]
    else
      [
        Product.joins(:category).where.not(categories: { category_type: 'daily' }).order('products.active DESC'),
        { carta: 'oscuro', menu: 'clarito' }
      ]
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(:title, :description, :prize, :category_id, :picture, allergen_ids: [])
  end
end
