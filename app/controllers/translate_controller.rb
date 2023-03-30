require 'httparty'

class TranslateController < ApplicationController
  def translate
    text = params[:text]
    target_lang = 'EN'
    auth_key = 'b1374b82-122a-e489-9d9c-f289835c5dc8:fx'

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
end
