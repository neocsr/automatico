require 'faye'
require 'eventmachine'
require 'json'

EM.run {
  client = Faye::Client.new('http://localhost:9292/faye')

  client.subscribe('/commands') do |message|
    printf message.inspect

    thread = Thread.new do
      args = %w[-r ./spec/json_formatter.rb -f JsonFormatter]
      results = IO.popen("bundle exec rspec #{args.join(' ')} ./spec/hello_spec.rb")
      until results.eof?
        printf "."
        client.publish('/results', JSON(results.gets))
        sleep 1
      end
      printf "\n"
    end
  end

  client.publish('/common', 'text' => "Joined #{self}")
}
