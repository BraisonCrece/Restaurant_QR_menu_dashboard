require "httparty"

class DescriptionController < ApplicationController
  def describe_dish
    plato = params[:plato]
    description_type = params[:description_type] || "plato"

    prompts = {
      plato: "Dado un prato de comida, describe brevemente e en Galego o prato para unha carta dixital dun restaurante, indicando os ingredentes, sabores, historia, referencias, cultura, etc. Máximo 250 caracteres. Non remates con referencias ao paladar do comensal. \nExemplo: \n- Prato: Cordeiro leital a baixa temperatura \n- Descrición: Tenro e suculento cordeiro leital, cocido a baixa temperatura para preservar a súa textura e sabores e rematado á prancha. Acompañado de patacas asadas e vexetais frescos. \n- Prato: #{plato} \n- Descrición:",
      vino: "Dada a marca ou o nome dun viño, describeo brevemente en Galego para unha carta dixital dun restaurante, facendo referencias ao seu sabor, cor, matices, tipo de uva, orixe, etc. Máximo 250 caracteres.\nExemplo: \n- Viño: Casal de Armán \n- Descrición: Elegante branco da Ribeira Sacra, elaborado con Treixadura. Cor amarela pálida e refuxos dourados. Aromas a froitas de carozo, flores brancas e cítricos. Fresco, equilibrado e sedoso no paladar, cun toque de froita madura. Marida con mariscos, pescados e queixos suaves. \n- Viño: #{plato} \n- Descrición:",
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
