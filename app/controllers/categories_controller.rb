class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoríá agregada con éxito"
      render :new, status: :ok
      flash.clear
    else
      flash[:alert] = "Datos inválidos"
      render :new, status: :unprocessable_entity
      flash.clear
    end
  end

  def edit

  end

  def update

  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
