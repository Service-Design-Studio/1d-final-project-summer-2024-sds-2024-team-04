# features/support/capybara.rb

require 'capybara'
require 'capybara/cucumber'

# Choose your preferred Capybara driver
Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome # If you need JavaScript support

# Optionally set the maximum time Capybara should wait for an element to appear
Capybara.default_max_wait_time = 10

# If you're using Rails, configure Capybara to use the correct app host
Capybara.app_host = 'http://localhost:3000' # Adjust to match your Rails server URL

# Optionally configure additional settings like screen size for headless testing
# Capybara.register_driver :selenium_chrome_headless do |app|
#   options = Selenium::WebDriver::Chrome::Options.new(args: ['headless', 'disable-gpu'])
#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end
# Capybara.javascript_driver = :selenium_chrome_headless

# Optionally configure default selector type (CSS or XPath)
Capybara.default_selector = :css
