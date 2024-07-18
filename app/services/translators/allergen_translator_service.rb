# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Translators
  class AllergenTranslatorService
    include Dry::Monads[:result, :try]
    include Dry::Monads::Do.for(:call)

    attr_reader :allergen, :language, :temperature, :model, :name_system_message,
                :example_name, :example_name_response

    def initialize(allergen, language, temperature: 0.3, model: 'gpt-4o-mini')
      @allergen = allergen
      @language = language
      @temperature = temperature
      @model = model
      @name_system_message = %(Actúa como un servicio de traducción. O ususario pasarache o nome dun alérxeno alimentario e debes
      respostar soamente coa traducción precisa do alérxeno. Traducirás do Galego ao #{language}.)
    end

    def call
      yield initialize_example_prompts
      file_path = yield get_file_path
      file_content = yield get_file_content(file_path)
      name_translation = yield ask_for_translation(name_system_message, example_name, example_name_response,
                                                   allergen.name)
      save_translation(file_path, file_content, name_translation)
    end

    private

    def initialize_example_prompts
      @example_name = 'Leite'
      @example_name_response = example_responses(language)
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

    def ask_for_translation(system_message, example_prompt, example_response, prompt)
      result = OpenAiService.new.request(system_message:, prompt:, example_prompt:, example_response:, model:,
                                         temperature: 0.3)
      if result.success?
        # Remove the final period in case it was added by the AI
        result.content.chomp!('.') if result.content.end_with?('.')
        Success(result.content)
      else
        Failure(result.error)
      end
    end

    def save_translation(file_path, file_content, name_translation)
      file_content[get_language_key(language)]['allergen'][allergen.id] = {
        'name' => name_translation
      }

      result = Try[Errno::ENOENT, Errno::EACCES] do
        File.open(file_path, 'w') { |file| file.write(YAML.dump(file_content)) }
      end.to_result

      Rails.logger.error("Failed to save translation: #{result.failure}") if result.failure?
      result
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
        'Milk'
      when 'Español'
        'Leche'
      when 'Alemán'
        'Milch'
      when 'Italiano'
        'Latte'
      when 'Francés'
        'Lait'
      when 'Ruso'
        'Молоко'
      end
    end
  end
end
