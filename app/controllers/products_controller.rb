class ProductsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @products = Product.all
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
  end

  def update
  end

  def remove
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :prize, :picture, allergen_ids: [])
  end
end
