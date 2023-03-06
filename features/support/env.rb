require 'cucumber/rails'
require 'webdrivers'

require 'simplecov'
SimpleCov.start 'rails'

# require 'rspec' #for page.shoud etc
# require 'capybara/cucumber'
# require 'cucumber'
# require 'pry'
# require "selenium-webdriver"
# Ask capybara to register a driver called 'selenium'
# options = Selenium::WebDriver::Firefox::Options.new
# options.add_argument('--headless')
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(
#       app,

#       #what browser do we want? Must match whatever is in our seleniarm stand-alone image
#       # browser: :firefox, 
#       browser: :remote, 

#       # desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox,

#       options: options,
      
#       #where does it live? By passing a URL we tell capybara to use a selenium grid instance (not local)
#       # url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}" 
#   )
# end
# Capybara.server_host = '0.0.0.0'
# # make the driver we just registered our default driver
# # Capybara.default_driver = :selenium
# Capybara.javascript_driver = :selenium
# # Capybara.default_driver = :selenium_chrome

# # # set the default URL for our tests
# Capybara.app_host = "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}"

# require 'selenium-webdriver'

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :firefox, url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub")
# end
# # Capybara.default_driver = :selenium
# Capybara.javascript_driver = :selenium


# Capybara.configure do |config|
#   config.app_host = 'http://localhost:3000'
#   config.server_host = "#{ENV['SELENIUM_HOST']}"
#   config.server_port = "#{ENV['SELENIUM_PORT']}"
# end

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :firefox, url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub")
# end
# Capybara.default_driver = :selenium
# # Capybara.javascript_driver = :selenium

# require 'rspec' #for page.shoud etc
require 'capybara/cucumber'
require 'cucumber'
require 'pry'

require "selenium-webdriver"

if Rails.configuration.use_remote_webdriver
  # Ask capybara to register a driver called 'selenium'
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(
        app,

        #what browser do we want? Must match whatever is in our seleniarm stand-alone image
        browser: :firefox, 
        
        #where does it live? By passing a URL we tell capybara to use a selenium grid instance (not local)
        url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}" 
    )
  end

  # make the driver we just registered our default driver
  Capybara.default_driver = :selenium

  # set the default URL for our tests
  Capybara.server_host = "0.0.0.0"
  Capybara.server_port = 3000
  Capybara.app_host = "http://ruby:#{Capybara.server_port}"
else
  Capybara.default_driver = :selenium_chrome
end


# Capybara.app_host = "http://ruby-ssh:3000"
# # "http://#{ENV['RAILS_HOST']}:#{ENV['RAILS_PORT']}" 

















# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

# frozen_string_literal: true

# frozen_string_literal: true

# frozen_string_literal: true

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { except: [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('not @no-txn', 'not @selenium', 'not @culerity', 'not @celerity', 'not @javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation
