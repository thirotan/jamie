ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'capybara'

RSpec.configure do |conf|
  conf.include Capybara::DSL
  conf.include Rack::Test::Methods
end

def app                                                                                                                                    
  Capybara.app = SinatraApp::Application                                                                                                                  
end                                                                                                                                        
