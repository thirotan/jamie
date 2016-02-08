ENV['RACK_ENV'] = 'test'


require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'sinatraapp', 'app.rb')

Capybara.configure do |config|
  config.app_host = 'http://0.0.0.0:9292/'
end

RSpec.configure do |conf|
  conf.include Capybara::DSL
  conf.include Rack::Test::Methods

end

#def setup
  Capybara.app = SinatraApp::Application
#end
