ENV['RACK_ENV'] = 'test'


require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

RSpec.configure do |conf|
  conf.include Capybara::DSL
  conf.include Rack::Test::Methods

end

def app
  SinatraApp::Application
end
