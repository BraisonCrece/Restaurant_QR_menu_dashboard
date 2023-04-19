class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @categories = Category.all
    @categorized_products = Product.categorized_products
    @denominations = WineOriginDenomination.all.includes(:wines)
    @available_colors = ['Blanco', 'Tinto']
    @categorized_wines = categorized_wines
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.active = true

    if params[:product][:picture]
      @product.process_image(params[:product][:picture])
    end

    if @product.save
      flash[:notice] = "Producto engadido!"
      render :new, status: :ok
      flash.clear
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    session[:scroll_position] = params[:scroll_position]
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
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
    @products = Product.all
  end

  def toggle_active
    product = Product.find(params[:product_id])
    product.update(active: !product.active)
    render turbo_stream: turbo_stream.replace("product_active_#{product.id}", partial: 'products/active', locals: {product: product})
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :prize, :category_id, :picture, allergen_ids: [])
  end

  def categorized_wines
    wines_by_color_and_denomination = {}
    @available_colors.each do |color|
      wines_by_color_and_denomination[color] = {}
      @denominations.each do |denomination|
        wines = denomination.wines.where(active: true, wine_type: color).order(name: :asc)
        wines_by_color_and_denomination[color][denomination.id] = wines unless wines.blank?
      end
    end
    wines_by_color_and_denomination
  end
end



