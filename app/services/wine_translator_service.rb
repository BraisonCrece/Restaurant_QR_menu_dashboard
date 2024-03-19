# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class WineTranslatorService
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  attr_reader :wine, :language, :description_translation, :description_prompt

  def initialize(wine, language)
    @wine = wine
    @language = language
    @description_prompt = "Eres un experto linguista, as túas respostas so conteñen a traducción, nada máis. Quero que traduzas a descrición do seguinte viño do Galego ao #{language}: \n #{wine.description}"
  end

  def call
    file_path = yield get_file_path
    file_content = yield get_file_content(file_path)
    description_translation = yield ask_for_translation(description_prompt)
    save_translation(file_path, file_content, description_translation)
  end

  private

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

  def save_translation(file_path, file_content, description_translation)
    file_content[get_language_key(language)]['wine'][wine.id] = {
      'description' => description_translation
    }

    Try[Errno::ENOENT, Errno::EACCES] do
      File.open(file_path, 'w') { |file| file.write(YAML.dump(file_content)) }
    end.to_result
  end

  def ask_for_translation(prompt)
    result = OpenAiService.new.request(prompt, 'gpt-3.5-turbo-0125', 0.7)
    if result.success?
      # Remove the final period in case it was added by the AI
      result.content.chomp!('.') if result.content.end_with?('.')
      Success(result.content)
    else
      Failure(result.error)
    end
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
end
