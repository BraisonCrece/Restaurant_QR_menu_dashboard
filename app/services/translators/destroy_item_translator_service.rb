# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module Translators
  class DestroyItemTranslatorService
    include Dry::Monads[:result, :try]
    include Dry::Monads::Do.for(:call)

    YAML_FILES = %w[es en fr de it ru].freeze
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def call
      yield process_item_destroy
      reload_i18n
    end

    private

    def process_item_destroy
      item_class = item.class.name.downcase
      result = YAML_FILES.each_with_object([]) do |language_key, result_accumulator|
        result_accumulator << Try do
          file_path = Rails.root.join('..', 'data', 'locales', "#{language_key}.yml")
          yaml_file = YAML.load_file(file_path)
          yaml_file[language_key][item_class].delete(item.id)
          File.open(file_path, 'w') { |file| file.write(YAML.dump(yaml_file)) }
        end.to_result
      end

      if result.any?(Failure)
        Rails.logger.error("Failed to delete translations for #{item_class} #{item.id}")
        return Failure("Failed translations: #{result.filter(&:failure?).map(&:failure).join(', ')}")
      end

      Rails.logger.info("Deleted translations for #{item_class} #{item.id}")
      Success('All translations deleted')
    end

    def reload_i18n
      I18n.reload!
      Success('Item removed and reloaded I18n')
    end
  end
end
