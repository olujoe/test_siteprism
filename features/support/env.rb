require 'rubygems' 
require 'yaml'
require 'pry'
require 'page-object'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'site_prism'

	config = YAML.load(File.read('config/config.yml'))
	HEALTH_CHECK = YAML.load(File.read('features/test_data/health_check.yml'))
    
	default_browser = config['default_browser']
	puts "Using default browser: #{default_browser}"

	#browser = Watir::Browser.new :"#{default_browser}"
	INDEX_OFFSET = -1
	WEBDRIVER = true
	
	TEST_ENV='qa'
	DATASET = config[TEST_ENV]
	ENV['VARIABLE'] = Time.now.strftime("%d%m%Y_%H%M") 
	ENV['email'] = config['default_email_address'] 
	ENV['password'] = config['default_password']
	
	
Capybara.configure do |config|
	config.default_driver = :selenium
	config.javascript_driver = :selenium
	config.run_server = false
	config.default_selector = :css
	config.default_wait_time = 5
	Capybara.app_host = DATASET['home_page']

	#capybara 2.1 config options
	config.match = :prefer_exact
	config.ignore_hidden_elements = false
end

Capybara.register_driver :selenium do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile["browser.cache.disk.enable"] = false
  profile["browser.cache.memory.enable"] = false
  Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile)
end
