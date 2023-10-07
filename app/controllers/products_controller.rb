class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :menu, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :new, :edit]

  def index
    if Setting.use_menu_path?
        redirect_to menu_path
    else
        @categorized_products = Product.categorized_products
        @denominations = WineOriginDenomination.all.includes(:wines)
        @available_colors = ["Blanco", "Tinto"].freeze
        @categorized_wines = Wine.categorized_wines(@denominations, @available_colors)
    end
  end

  def menu
    @categorized_products = Product.menu_categorized_products
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.active = true

    if params[:product][:picture]
      if params[:product][:picture].content_type == "image/webp"
        flash.now[:alert] = "Formatos de imaxe disponibles: jpeg, png"
        render :new
        return
      else
        @product.process_image(params[:product][:picture])
      end
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
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    if params[:product][:picture]
      @product.process_image(params[:product][:picture])
    end
    if @product.update(product_params)
      redirect_to control_panel_path, notice: "Producto editado con éxito"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to control_panel_path, status: 303, notice: "Producto eliminado!"
  end

  def control_panel
    case params[:filter]
    when "menu"
      @products = Product.menu_categorized_products
    else
      @products = Product.categorized_products
    end
  end

  def pages_control
    @settings = Setting.first
  end

  def toggle_active
    product = Product.find(params[:product_id])
    product.update(active: !product.active)
    render turbo_stream: turbo_stream.replace("product_active_#{product.id}", partial: "products/active", locals: { product: product })
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(:title, :description, :prize, :category_id, allergen_ids: [])
  end
end
