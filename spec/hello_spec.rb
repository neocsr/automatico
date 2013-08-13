require 'ruby-debug'
require "bundler"
Bundler.require :default

class Reporter
  include HTTParty
  base_uri 'http://localhost:9292'
end

class IpAddress
  include HTTParty
  base_uri 'http://ip.jsontest.com'
end

describe IpAddress do
  it "returns an ip address" do
    path = "/"
    response = IpAddress.get path
    expected = { "ip" => "108.199.226.79" }

    body = {
      :channel => '/details',
      :data => {
        :endpoint => "#{IpAddress.base_uri}#{path}",
        :response => response.parsed_response
      }
    }.to_json
    Reporter.post '/faye',
      :body => body,
      :headers => { 'Content-Type' => 'application/json' }

    response.parsed_response.should == expected
  end
end
