require 'faye'

Faye::WebSocket.load_adapter('thin')

map '/faye' do
  run Faye::RackAdapter.new(:mount => '/', :timeout => 25)
end

map '/' do
  run Rack::File.new("./public/")
end
