require 'httparty'
class DescriptionController < ApplicationController
  def describe_dish
    plato = params[:plato]
    description_type = params[:description_type] || 'plato'

    prompts = {
      plato: "Dado un prato de comida, describe brevemente o prato para unha carta dixital dun restaurante nun ton formal e adecuado e como se o escribise o cociñeiro do restaurante. Máximo 200 caracteres.\nExemplo: Prato: Polvo á feira\nDescrición: Unha das xoias da cociña galega. Con todo o sabor e autenticidade que define á nosa cultura gastronómica. O polbo, cociñado a perfección e cortado en rodas suculentas, acompáñase con cachelos que dá o toque máxico de sabor e aroma. O aceite de oliva, o pemento doce e a sal gorda unen as súas forzas para crear unha explosión de sabor en cada bocado.\nPrato: #{plato}\nDescrición:",
      vino: "Dada a marca ou o nome dun viño, describe brevemente o viño para unha carta dixital dun restaurante nun ton formal e adecuado, coma se foses un experto enólogo e sommelier. Máximo 200 caracteres. En galego.\nExemplo: Viño: Casal de Armán\nDescrición: Combinamos uva de viñas con distintos tipos de chan e orientacións, exclusivamente no Val do Avia, para representar a tipicidade dos vinos desta zona  histórica ao norte da D.O. Ribeiro, para dar como resultado un viño de boa estructura e carácter graso, con aromas a nectarina, fiúncho, flores brancas, e un final persistente e elegantemente amargoso.\nViño: #{plato}\nDescrición:"
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

