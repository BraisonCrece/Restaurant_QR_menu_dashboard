class WineOriginDenominationsController < ApplicationController
  before_action :set_denomination, only: [:show, :edit, :update, :destroy]

  def index
    @denominations = WineOriginDenomination.all
  end

  def show
  end

  def new
    @denomination = WineOriginDenomination.new
  end

  def edit
  end

  def create
    @denomination = WineOriginDenomination.new(wine_origin_denomination_params)

    if @denomination.save
      flash[:notice] = 'Denominación de origen creada con éxito.'
      render :new
      flash.clear
    else
      flash[:alert] = "Houbo un erro"
      render :new, status: :unprocessable_entity
      flash.clear
    end
  end

  def update
    if @denomination.update(wine_origin_denomination_params)
      redirect_to denominations_path, notice: 'Denominación de origen actualizada con éxito.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @denomination.destroy
    redirect_to denominations_path, notice: 'Denominación de origen eliminada con éxito.'
  end

  private
    def set_denomination
      @denomination = WineOriginDenomination.find(params[:id])
    end

    def wine_origin_denomination_params
      params.require(:wine_origin_denomination).permit(:name)
    end
end
