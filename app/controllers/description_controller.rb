require 'httparty'
class DescriptionController < ApplicationController
  def describe_dish
    plato = params[:plato]
    description_type = params[:description_type] || 'plato'

    prompts = {
      plato: "Dado un prato de comida, describe brevemente o prato para unha carta dixital dun restaurante nun ton formal e adecuado e como se o escribise o cociñeiro do restaurante. Máximo 150 caracteres.\nExemplo: Prato: Cordeiro leital a baixa temperatura\nDescrición: Cordeiro leital cociñado a baixa temperatura, acompáñase con deliciosos espárragos verdes e puré de pataca.\nPrato: #{plato}\nDescrición:",
      vino: "Dada a marca ou o nome dun viño, describe brevemente o viño para unha carta dixital dun restaurante nun ton formal e adecuado, coma se foses un experto enólogo e sommelier. Máximo 150 caracteres. En galego.\nExemplo: Viño: Casal de Armán\nDescrición: Combinamos uva de viñas con distintos tipos de chan e orientacións, exclusivamente no Val do Avia, para representar a tipicidade dos vinos desta zona  histórica ao norte da D.O. Ribeiro, para dar como resultado un viño de boa estructura e carácter graso, con aromas a nectarina, fiúncho, flores brancas, e un final persistente e elegantemente amargoso.\nViño: #{plato}\nDescrición:"
    }

    prompt = prompts[description_type.to_sym]

    begin
      open_ai_service = OpenAiService.new
      description = open_ai_service.get_description(prompt)
      render json: { description: description }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end

