require 'httparty'
class DescriptionController < ApplicationController
  def describe_dish
    api_key = Rails.application.credentials.openai
    plato = params[:plato]

    prompt = "Dado un prato de comida, describe brevemente o prato para unha carta dixital dun restaurante nun ton formal e adecuado e como se o escribise o cociñeiro do restaurante. Máximo 300 caracteres.\nExemplo: Prato: Polvo á feira\nDescrición: O Polvo á feira é, sen dúbida, unha das xoias da cociña galega. Este prato ten todo o sabor e autenticidade que define á nosa cultura gastronómica. O polbo, cociñado a perfección e cortado en rodas suculentas, acompáñase con patacas tenras e unha salsa tradicional que dá o toque máxico de sabor e aroma. O aceite de oliva, o pemento doce e a sal gorda unen as súas forzas para crear unha explosión de sabor en cada bocado.\nPrato: #{plato}\nDescrición:"

    url = 'https://api.openai.com/v1/chat/completions'
    headers = {
      'Authorization': "Bearer #{api_key}",
      'Content-Type': 'application/json'
    }
    body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content": prompt
        }
      ],
      "temperature": 0.7
    }
    response = HTTParty.post(url, headers: headers, body: body.to_json)
    if response.success?
      render json: { description: response['choices'][0]['message']['content'] }, status: :ok
    else
      render json: { error: 'Error fetching description' }, status: :unprocessable_entity
    end
  end
end

