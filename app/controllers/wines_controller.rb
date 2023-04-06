class WinesController < ApplicationController
  before_action :set_wine, only: [:show, :edit, :update, :destroy]

  def index
    @wines = Wine.all
  end

  def show
  end

  def new
    @wine = Wine.new
  end

  def edit
  end

  def create
    @wine = Wine.new(wine_params)

    if @wine.save
      redirect_to wines_control_panel_path, notice: 'Viño creado con éxito.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @wine.update(wine_params)
      redirect_to wines_control_panel_path, notice: 'Viño actualizado con éxito.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @wine.destroy
    redirect_to wines_control_panel_path, notice: 'Viño eliminado!'
  end

  def control_panel
    @wines = Wine.all
  end

  def toggle_active
    wine = Wine.find(params[:wine_id])
    wine.update(active: !wine.active)
    render turbo_stream: turbo_stream.replace("wine_active_#{wine.id}", partial: 'wines/active', locals: {wine: wine})
  end

  private
    def set_wine
      @wine = Wine.find(params[:id])
    end

    def wine_params
      params.require(:wine).permit(:name, :description, :wine_type, :wine_origin_denomination_id, :price, :price_per_glass, :image)
    end
end
