require 'bundler/setup'
require 'omniauth-ada'
require './app.rb'

use Rack::Session::Cookie, secret: 'abc123'

use OmniAuth::Builder do
  provider :ada, ENV['APP_ID'], ENV['APP_SECRET']
end

run Sinatra::Application
