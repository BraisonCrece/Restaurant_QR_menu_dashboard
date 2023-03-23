class AllergensController < ApplicationController
  before_action :authenticate_user!
  def index
    @allergens = Allergen.all
  end

  def new
    @allergen = Allergen.new
  end

  def create
    @allergen = Allergen.new(allergen_params)
    if @allergen.save
      flash[:notice] = "Alérgeno agregado con éxito"
      render :new, status: :ok
      flash.clear
    else
      flash[:alert] = "Datos inválidos"
      render :new, status: :unprocessable_entity
      flash.clear
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private
  def allergen_params
    params.require(:allergen).permit(:name, :icon)
  end
end
