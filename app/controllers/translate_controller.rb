require 'httparty'

class TranslateController < ApplicationController
  def translate
    text = params[:text]
    target_lang = 'EN'
    auth_key = ENV['AUTH_KEY']

    url = 'https://api-free.deepl.com/v2/translate'
    headers = {
      'Authorization': "DeepL-Auth-Key #{auth_key}",
      'Content-Type': 'application/x-www-form-urlencoded'
    }
    body = {
      'text': text,
      'target_lang': target_lang
    }

    response = HTTParty.post(url, headers: headers, body: body)
    if response.success?
      render json: { translation: response['translations'][0]['text'] }, status: :ok
    else
      render json: { error: 'Error fetching translation' }, status: :unprocessable_entity
    end
  end

  def reload_i18n
    I18n.reload!
    redirect_to root_path, notice: 'I18n reloaded'
  end
end
