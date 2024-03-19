class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&action)
    if params[:locale]
      locale = params[:locale] || I18n.default_locale
      session[:locale] = locale
    end

    I18n.with_locale(session[:locale], &action)
  end
end
