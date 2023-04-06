require 'httparty'
class DescriptionController < ApplicationController
  def describe_dish
    api_key = Rails.application.credentials.openai
    plato = params[:plato]
    description_type = params[:description_type] || 'plato'

    prompts = {
      plato: "Dado un prato de comida, describe brevemente o prato para unha carta dixital dun restaurante nun ton formal e adecuado e como se o escribise o cociñeiro do restaurante. Máximo 300 caracteres.\nExemplo: Prato: Polvo á feira\nDescrición: O Polvo á feira é, sen dúbida, unha das xoias da cociña galega. Este prato ten todo o sabor e autenticidade que define á nosa cultura gastronómica. O polbo, cociñado a perfección e cortado en rodas suculentas, acompáñase con patacas tenras e unha salsa tradicional que dá o toque máxico de sabor e aroma. O aceite de oliva, o pemento doce e a sal gorda unen as súas forzas para crear unha explosión de sabor en cada bocado.\nPrato: #{plato}\nDescrición:",
      vino: "Dada a marca dun viño, describe brevemente o viño para unha carta dixital dun restaurante nun ton formal e adecuado. Máximo 300 caracteres. En galego.\nExemplo: Viño: Casal de Armán\nDescrición: Combinamos uva de viñas con distintos tipos de chan e orientacións, exclusivamente no Val do Avia, para representar a tipicidade dos vinos desta zona  histórica ao norte da D.O. Ribeiro, para dar como resultado un viño de boa estructura e carácter graso, con aromas a nectarina, fiúncho, flores brancas, e un final persistente e elegantemente amargoso.\nViño: #{plato}\nDescrición:"
    }

    prompt = prompts[description_type.to_sym]

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

