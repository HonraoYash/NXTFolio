# # from https://cucumber.io/docs/cucumber/debugging/?lang=ruby

# # These debugging tools can be used by setting an environment variable:
# # export VARIABLE_NAME=value

# # rubocop:disable Lint/Debugger
# class CucumberCounters
#     @error_counter = 0
#     @step_counter = 0
#     @screenshot_counter = 0
#     class << self
#         attr_accessor :error_counter, :step_counter, :screenshot_counter
#     end
# end

# # `LAUNCHY=1 cucumber` to open save screenshot after every step
# After do |scenario|
#     next unless (ENV['LAUNCHY'] || ENV['CI']) && scenario.failed?
#     puts "Opening snapshot for #{scenario.name}"
#     begin
#     save_and_open_screenshot
#     rescue StandardError
#     puts "Can't save screenshot"
#     end
#     begin
#     save_and_open_page
#     rescue StandardError
#     puts "Can't save page"
#     end
# end

# # `FAST=1 cucumber` to stop on first failure
# After do |scenario|
#     Cucumber.wants_to_quit = ENV['FAST'] && scenario.failed?
# end

# `DEBUG=1 cucumber` to drop into debugger on failure
# Cucumber::Core::Test::Action.class_eval do
#     ## first make sure we don't lose original accept method
#     unless instance_methods.include?(:orig_failed)
#     alias_method :orig_failed, :failed
#     end

#     ## wrap original accept method to catch errors in executed step
#     def failed(*args)
#         begin
#             CucumberCounters.error_counter += 1
#             file_name = format('tmp/capybara/error_%03d.png',
#                             CucumberCounters.error_counter)
#             Capybara.page.save_screenshot(file_name, full: true)
#         rescue
#             Rails.logger.info('[Cucumber] Can not make screenshot of failure')
#         end
#         binding.pry if ENV['DEBUG']=="1"
#         orig_failed(*args)
#     end
# end

# #   # Store the current scenario name as an instance variable, to make it
# #   # available to the other hooks.
# #   Before do |scenario|
# #     case scenario
# #     when Cucumber::Ast::Scenario
# #       @scenario_name = scenario.name
# #     when Cucumber::Ast::OutlineTable::ExampleRow
# #       @scenario_name = scenario.scenario_outline.name
# #     end
# #     Rails.logger.info("[Cucumber] starting the #{@scenario_name}")
# #   end

# # `STEP=1 cucumber` to pause after each step
# AfterStep do |scenario|
#     next unless ENV['STEP']
#     unless defined?(@counter)
#         puts "Stepping through #{@scenario_name}"
#         @counter = 0
#     end
#     @counter += 1
#     print "After step ##{@counter} '[RETURN to continue]'..."
#     # print "After step ##{@counter}/#{scenario.send(:steps).try(:count)}: "\
#     #     "#{scenario.send(:steps).to_a[@counter].try(:name) ||
#     #     '[RETURN to continue]'}..."
#     STDIN.getc
# end

# AfterStep do |scenario|
#     CucumberCounters.step_counter += 1
#     step = CucumberCounters.step_counter
#     file_name = format('tmp/capybara/step_%03d.png', step)
#     Rails.logger.info("[Cucumber] after step: #{@scenario_name}, step: #{step}")
#     next unless scenario.source_tag_names.include?('@intermittent')
#     begin
#     Capybara.page.save_screenshot(file_name, full: true)
#     Rails.logger.info("[Cucumber] Screenshot #{step} saved")
#     rescue
#     Rails.logger.info("[Cucumber] Can not make screenshot of #{step}")
#     end
# end

# AfterStep do
#     begin
#     execute_script "$(window).unbind('beforeunload')"
#     rescue => e
#     Rails.logger.error("An error was encountered and rescued")
#     Rails.logger.error(e.backtrace)
#     end
# end

# def dismiss_nav_warning
#     execute_script "$(window).unbind('beforeunload')"
#     wait_until_jquery_inactive
# end

# def wait_until_jquery_inactive
#     Capybara.using_wait_time(Capybara.default_max_wait_time) do
#     page.evaluate_script('jQuery.active').zero?
#     end
# end
