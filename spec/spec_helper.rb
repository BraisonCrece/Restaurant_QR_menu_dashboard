# require 'pry'
require 'factory_bot_rails'
require 'faker'
require 'capybara-screenshot/rspec'

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot_#{example.description.tr(' ', '-').downcase}"
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.after(:each) do |example|
    if example.exception
      filename_prefix = example.metadata[:screenshot][:filename_prefix]
      page.save_screenshot("#{filename_prefix}-#{Time.now.to_i}.png")
    end
  end

  # Resto de la configuración...
end
