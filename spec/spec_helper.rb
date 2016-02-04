ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'capybara'

RSpec.configure do |conf|
  config.include Capybara::DSL
  conf.include Rack::Test::Methods
end

def app                                                                                                                                    
  SinatraApp::Application                                                                                                                  
end                                                                                                                                        
