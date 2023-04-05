class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
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
    if @category.update(category_params)
      flash[:notice] = "Categoría actualizada con éxito"
      redirect_to categories_path
    else
      flash[:alert] = "Datos inválidos"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Categoría eliminada con éxito"
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
  def set_category
    @category = Category.find(params[:id])
  end
end
