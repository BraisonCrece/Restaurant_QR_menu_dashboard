class SettingsController < ApplicationController
  def edit
    @setting = Setting.first
  end

  def update
    @setting = Setting.first
    if @setting.update(setting_params)
      redirect_to pages_control_path, notice: "Configuración actualizada con éxito"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:root_page, :show_toggler)
  end
end
