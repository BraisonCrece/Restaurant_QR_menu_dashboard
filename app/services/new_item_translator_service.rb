# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class NewItemTranslatorService
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  LANGUAGES = %w[Español Inglés Francés Alemán Italiano Ruso].freeze
  attr_reader :item, :notify

  def initialize(item)
    @item = item
  end

  def call
    result = yield process_item_translations
    yield activate_item
  end

  def process_item_translations
    result = LANGUAGES.each do |language|
      service = Try do
        "#{item.class.name}TranslatorService".constantize.new(item, language)
      end.to_result

      raise "Service #{item.class.name}TranslatorService not found" if service.failure?

      result = service.success.call
      if result.success?
        Rails.logger.info("#{item.class.name} #{item.id} translated to #{language}")
        Success("#{item.class.name} #{item.id} translated")
      else
        Rails.logger.error("#{item.class.name} #{item.id} failed to translate to #{language}, #{result.failure}")
        Failure("#{item.class.name} #{item.id} failed to translate")
      end
    end
    result.all? ? Success('All translations successful') : Failure("Failed translations: #{result.filter(&:failure?).map(&:failure).join(', ')}")
  end

  def activate_item
    I18n.backend.reload!

    activation_result = Try[ActiveRecord::RecordInvalid] do
      item.update!(lock: false, active: true)
    end.to_result

    return Failure(activation_result.failure) if activation_result.failure

    Rails.logger.info("Item #{item.class.name} #{item.id} activated")
    Success("#{item.class.name} #{item.id} activated")
  end
end
