$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatraapp/app'
run SinatraApp::Application
