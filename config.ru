require 'faye'
require './faye_websocket_app.rb'

Faye::WebSocket.load_adapter('thin')

map '/websocket' do
  run FayeWebSocketApp
end

map '/faye' do
  run Faye::RackAdapter.new(:mount => '/', :timeout => 25)
end

map '/' do
  run Rack::File.new("./public/")
end
