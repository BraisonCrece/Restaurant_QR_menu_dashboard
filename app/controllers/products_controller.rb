class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @products = Product.where(active: true)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.active = false
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
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, status: 303, notice: 'El producto fue eliminado correctamente.'
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
    params.require(:product).permit(:title, :description, :prize, :picture, allergen_ids: [])
  end
end
