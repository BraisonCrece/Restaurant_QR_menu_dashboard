require 'httparty'

class DescriptionController < ApplicationController
  def describe_dish
    plato = params[:plato]
    description_type = params[:description_type] || 'plato'

    system_messages = {
      plato: 'Eres un experto en cociña e en definir platos para a carta dun restaurante. As túas respostas limítanse a dar a descripción dun prato dado dun xeito profesional e atractivo, limitando esta a 250 caracteres para manter concisión e interese. A interacción co usuario será completamente en Galego',
      vino: 'Eres un experto en viños e en describir estos viños para a carta dun restaurante. Para cada viño, xera unha descrición breve en Galego. Destaca sabor, cor, matices e notas de cata, tipo de uva, rexión de orixe e recomendacións de maridaxe cando sexa pertinente. Limítaa a 250 caracteres para manter concisión e interese. O formato das túas respostas ha de ser soamente a descripción en si, nada máis.'
    }

    example_prompt = {
      plato: 'Ensalada de folla de carballo con langostinos e boquerón',
      vino: 'Leirana'
    }

    example_response = {
      plato: 'Ensalada de folla de roble con langostinos e boquerón, aliñada con vinagreta caseira. Perfecta harmonía de mar e terra.',
      vino: 'Este viño é elaborado polo recoñecido enólogo Rodrigo Méndez coas mellores uvas albariño da zona do Val do Salnés. Leirana é un viño fresco e elegante, con notas florais e de froitas brancas. Un albariño de gran complexidade e persistencia en boca, ideal para acompañar mariscos e peixes frescos.'
    }

    system = system_messages[description_type.to_sym]

    begin
      open_ai_service = OpenAiService.new
      description = open_ai_service.request(system_message: system, prompt: plato, example_prompt: example_prompt[description_type.to_sym], example_response: example_response[description_type.to_sym], temperature: 0.4).content
      render json: { description: }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
