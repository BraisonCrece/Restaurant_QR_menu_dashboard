# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Translators
  class WineTranslatorService
    include Dry::Monads[:result, :try]
    include Dry::Monads::Do.for(:call)

    attr_reader :wine, :language, :model, :temperature, :system_message, :example_description,
                :example_description_response

    def initialize(wine, language, temperature: 0.3, model: 'gpt-4o-mini')
      @wine = wine
      @language = language
      @temperature = temperature
      @model = model
      @system_message = %(Actúa como un servicio de traducción. O usuario pasarache a descripción dun viño e ti debes
    respostar soamente coa traducción precisa da descripción dada. Traducirás do Galego ao #{language}.)
    end

    def call
      yield initialize_example_prompts
      file_path = yield get_file_path
      file_content = yield get_file_content(file_path)
      description_translation = yield ask_for_translation
      save_translation(file_path, file_content, description_translation)
    end

    private

    def initialize_example_prompts
      @example_description = 'Este viño de Telmo Rodriguez é unha ode á uva godello, cultivada nas terras bercianas baixo un clima extremo. O resultado é un viño fresco e equilibrado, con notas florais e cítricas, e unha acidez que o fai perfecto para acompañar mariscos e peixes. O Barreiro é unha aposta segura para quen busca un viño con personalidade e carácter propio.'
      @example_description_response = example_responses(language)
      Success('Example prompts initialized')
    end

    def get_file_path
      language_key = get_language_key(language)
      return Failure('Language not found') if language_key.nil?

      file_path = Rails.root.join('..', 'data', 'locales', "#{language_key}.yml")
      Success(file_path)
    end

    def get_file_content(file_path)
      if File.exist?(file_path)
        Success(YAML.load_file(file_path))
      else
        Failure('File not found')
      end
    end

    def ask_for_translation
      prompt = wine.description
      result = OpenAiService.new.request(system_message:, prompt:, example_prompt: example_description,
                                         example_response: example_description_response, model: 'gpt-4o-mini', temperature: 0.3)
      if result.success?
        # Remove the final period in case it was added by the AI
        result.content.chomp!('.') if result.content.end_with?('.')
        Success(result.content)
      else
        Failure(result.error)
      end
    end

    def save_translation(file_path, file_content, description_translation)
      file_content[get_language_key(language)]['wine'][wine.id] = {
        'description' => description_translation
      }

      Try[Errno::ENOENT, Errno::EACCES] do
        File.open(file_path, 'w') { |file| file.write(YAML.dump(file_content)) }
      end.to_result
    end

    def get_language_key(language)
      case language
      when 'Inglés'
        'en'
      when 'Español'
        'es'
      when 'Alemán'
        'de'
      when 'Italiano'
        'it'
      when 'Francés'
        'fr'
      when 'Ruso'
        'ru'
      end
    end

    def example_responses(language)
      case language
      when 'Inglés'
        'This Telmo Rodriguez wine is an ode to the Godello grape, grown in the lands of Bierzo under an extreme climate. The result is a fresh and balanced wine, with floral and citrus notes, and an acidity that makes it perfect to accompany seafood and fish. Barreiro is a safe bet for those looking for a wine with its own personality and character.'
      when 'Español'
        'Este vino de Telmo Rodriguez es una oda a la uva godello, cultivada en las tierras bercianas bajo un clima extremo. El resultado es un vino fresco y equilibrado, con notas florales y cítricas, y una acidez que lo hace perfecto para acompañar mariscos y pescados. El Barreiro es una apuesta segura para aquellos que buscan un vino con personalidad y carácter propio.'
      when 'Alemán'
        'Dieser Wein von Telmo Rodriguez ist eine Hommage an die Godello-Traube, die in der Region Bierzo unter extremen klimatischen Bedingungen angebaut wird. Das Ergebnis ist ein frischer und ausgewogener Wein mit blumigen und zitrusartigen Noten und einer Säure, die ihn zum perfekten Begleiter von Meeresfrüchten und Fisch macht. Der Barreiro ist eine sichere Wahl für alle, die einen Wein mit eigener Persönlichkeit und eigenem Charakter suchen.'
      when 'Italiano'
        "Questo vino di Telmo Rodriguez è un'ode all'uva Godello, coltivata nelle terre del Bierzo in un clima estremo. Il risultato è un vino fresco ed equilibrato, con note floreali e agrumate e un'acidità che lo rende perfetto per accompagnare frutti di mare e pesce. Il Barreiro è una scommessa sicura per chi è alla ricerca di un vino con una propria personalità e carattere."
      when 'Francés'
        "Ce vin de Telmo Rodriguez est une ode au raisin Godello, cultivé dans les terres de Bierzo sous un climat extrême. Le résultat est un vin frais et équilibré, avec des notes florales et d'agrumes, et une acidité qui le rend parfait pour accompagner les fruits de mer et les poissons. Le Barreiro est une valeur sûre pour ceux qui recherchent un vin doté d'une personnalité et d'un caractère propres."
      when 'Ruso'
        'Это вино от Тельмо Родригеса - ода винограду Годельо, выращенному на землях Бьерсо в экстремальных климатических условиях. В результате получилось свежее и сбалансированное вино с цветочными и цитрусовыми нотками, а также кислотностью, которая делает его идеальным сопровождением морепродуктов и рыбы. Barreiro - беспроигрышный вариант для тех, кто ищет вино с собственной индивидуальностью и характером.'
      end
    end
  end
end
