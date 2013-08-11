require 'faye/websocket'
require 'json'

FayeWebSocketApp = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :open do |event|
      p [:open]
      args = %w[-r ./spec/json_formatter.rb -f JsonFormatter]
      results = `bundle exec rspec #{args.join(' ')} ./spec/hello_spec.rb`

      results.split(/\n/).each do |result|
        printf "."
        ws.send(result)
      end

      printf "\n"
    end

    ws.on :message do |event|
      p [:message]
      ws.send('echo: ' + event.data)
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end

    ws.rack_response
  else
    [200, {'Content-Type' => 'text/plain'}, ['Faye server says hello']]
  end
end
