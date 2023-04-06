class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @categories = Category.all
    @denominations = WineOriginDenomination.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.active = true
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
end
