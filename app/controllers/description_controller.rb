require 'httparty'

class DescriptionController < ApplicationController
  def describe_dish
    plato = params[:plato]
    description_type = params[:description_type] || 'plato'

    prompts = {
      plato: "Eres un experto en cociña, as túas respostas limítanse a dar a descripción dun prato dado. \n Dado un nome dun prato, xera unha descrición en Galego para unha carta dun restaurante. Podes incluír ingredientes principais, técnica culinaria, e un toque cultural ou histórico cando sexa relevante. Evita valoracións subxectivas e enfócate en datos obxectivos e atractivos. Máximo 250 caracteres por descrición. O formato das túas respostas ha de ser soamente a descripción en si, nada máis. \nExemplo: \n- Prato: Cordeiro leital a baixa temperatura \n- Descrición: Cordeiro tenro cocido lentamente para maximizar sabor e textura, acompañado de patacas asadas e vexetais. Un clásico reinventado. \n- Prato: #{plato} \n- Descrición:",
      vino: "Para cada viño, xera unha descrición breve en Galego para incluír nunha carta dixital de restaurante. Destaca sabor, cor, matices e notas de cata, tipo de uva, rexión de orixe e recomendacións de maridaxe cando sexa pertinente. Limítaa a 250 caracteres para manter concisión e interese. O formato das túas respostas ha de ser soamente a descripción en si, nada máis. \nExemplo: \n- Viño: Casal de Armán \n- Descrición: Viño branco Ribeira Sacra, con Treixadura. Pálida cor amarela, brillos dourados. Notas de froitas de carozo, flores brancas, cítricos. Paladar fresco, equilibrado, sedoso, con froita madura. Ideal con mariscos, peixes, queixos suaves. \n- Viño: #{plato} \n- Descrición:"
    }

    prompt = prompts[description_type.to_sym]

    begin
      open_ai_service = OpenAiService.new
      description = open_ai_service.request(prompt).content
      render json: { description: }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
