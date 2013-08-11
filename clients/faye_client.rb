require 'faye'
require 'eventmachine'
require 'json'

EM.run {
  client = Faye::Client.new('http://localhost:9292/faye')

  client.subscribe('/results') do |message|
    puts message.inspect
  end

  client.subscribe('/commands') do |message|
    printf message.inspect

    args = %w[-r ./spec/json_formatter.rb -f JsonFormatter]
    results = `bundle exec rspec #{args.join(' ')} ./spec/hello_spec.rb`

    results.split(/\n/).each do |result|
      printf "."
      client.publish('/results', JSON(result))
    end

    printf "\n"
  end

  client.publish('/common', 'text' => "Joined #{self}")
}
