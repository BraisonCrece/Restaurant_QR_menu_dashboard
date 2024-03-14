# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class ProductTranslatorService
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  attr_reader :product, :language, :title_translation, :description_translation, :title_prompt, :description_prompt

  def initialize(product, language)
    @product = product
    @language = language
    @title_prompt = "Eres un experto linguista, as túas respostas so conteñen a traducción, nada máis. Quero que traduzas o nome do seguinte prato de comida do Galego ao #{language}: \n #{product.title}"
    @description_prompt = "Eres un experto linguista, as túas respostas so conteñen a traducción, nada máis. Quero que traduzas a descrición do seguinte prato de comida do Galego ao #{language}: \n #{product.description}"
  end

  def call
    file_path = yield get_file_path
    file_content = yield get_file_content(file_path)
    title_translation = yield ask_for_translation(title_prompt)
    description_translation = yield ask_for_translation(description_prompt)
    yield save_translation(file_path, file_content, title_translation, description_translation)
  end

  private

  def get_file_path
    language_key = get_language_key(language)
    return Failure('Language not found') if language_key.nil?

    file_path = Rails.root.join('config', 'locales', "#{language_key}.yml")
    Success(file_path)
  end

  def get_file_content(file_path)
    if File.exist?(file_path)
      Success(YAML.load_file(file_path))
    else
      Failure('File not found')
    end
  end

  def save_translation(file_path, file_content, title_translation, description_translation)
    file_content[get_language_key(language)][product.id] = {
      'title' => title_translation,
      'description' => description_translation
    }

    Try[Errno::ENOENT, Errno::EACCES] do
      File.open(file_path, 'w') { |file| file.write(YAML.dump(file_content)) }
    end.to_result
  end

  def ask_for_translation(prompt)
    result = OpenAiService.new.request(prompt)
    result.success? ? Success(result.content) : Failure(result.error)
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
