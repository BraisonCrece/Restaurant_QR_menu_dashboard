# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class TranslateDatabaseService
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  LANGUAGES = %w[Español Inglés Francés Alemán Italiano Ruso].freeze

  def call
    process_products_translations
    process_wines_translations
  end

  def process_products_translations
    LANGUAGES.each do |language|
      products = Product.all
      products.each do |product|
        result = ProductTranslatorService.new(product, language).call
        if result.success?
          Rails.logger.info("Product #{product.id} translated to #{language}")
        else
          Rails.logger.error("Product #{product.id} failed to translate to #{language}, #{result.failure}")
        end
      end
    end
    Success('All products translated')
  end

  def process_wines_translations
    LANGUAGES.each do |language|
      wines = Wine.all
      wines.each do |wine|
        result = WineTranslatorService.new(wine, language).call
        if result.success?
          Rails.logger.info("Wine #{wine.id} translated to #{language}")
        else
          Rails.logger.error("Wine #{wine.id} failed to translate to #{language}")
        end
      end
    end
    Success('All wines translated')
  end
end
