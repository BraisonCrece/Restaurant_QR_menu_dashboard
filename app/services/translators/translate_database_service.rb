# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Translators
  class TranslateDatabaseService
    include Dry::Monads[:result, :try]
    include Dry::Monads::Do.for(:call)

    attr_reader :yaml, :products, :wines

    LANGUAGES = %w[Español Inglés Francés Alemán Italiano Ruso].freeze

    def call
      yield get_yaml_file
      yield get_items
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

    def get_items
      @products = Product.all
      @wines = Wine.all
      Success('Items loaded')
    end

    def process_products_translations
      products.each do |product|
        NewItemTranslatorService.new(product).call
      end
      Success('Products translations processed')
    end

    def process_wines_translations
      wines.each do |wine|
        NewItemTranslatorService.new(wine).call
      end
      Success('Wines translations processed')
    end

    def reload_i18n_backend
      I18n.backend.reload!
      Success('All done! :)')
    end
  end
end
