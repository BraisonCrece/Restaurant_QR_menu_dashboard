# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class TranslateDatabaseService
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  attr_reader :yaml, :not_translated_products, :not_translated_wines

  LANGUAGES = %w[Español Inglés Francés Alemán Italiano Ruso].freeze

  def call
    yield get_yaml_file
    yield get_not_translated_items
    yield process_products_translations
    yield process_wines_translations
    yield reload_i18n_backend
  end

  private

  def get_yaml_file
    file_path = Rails.root.join('..', 'data', 'locales', 'es.yml')
    if File.exist?(file_path)
      @yaml = YAML.load_file(file_path)
      Success('YAML file loaded')
    else
      Failure('File not found')
    end
  end

  def get_not_translated_items
    already_translated_products = yaml['es']['product'].keys
    already_translated_wines = yaml['es']['wine'].keys
    @not_translated_products = Product.where('id NOT IN (?)', already_translated_products)
    @not_translated_wines = Wine.where('id NOT IN (?)', already_translated_wines)
    if not_translated_products.empty? && not_translated_wines.empty?
      Failure('All items already translated :)')
    else
      Success('Items to translate found')
    end
  end

  def process_products_translations
    not_translated_products.each do |product|
      NewItemTranslatorService.new(product).call
    end
    Success('Products translations processed')
  end

  def process_wines_translations
    not_translated_wines.each do |wine|
      NewItemTranslatorService.new(wine).call
    end
    Success('Wines translations processed')
  end

  def reload_i18n_backend
    I18n.backend.reload!
    Success('All done!')
  end
end
