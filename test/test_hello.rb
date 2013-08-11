require 'minitest/autorun'
require 'ruby-debug'
require 'bundler'
Bundler.require(:default)

class Home < Minitest::Test
  include HTTParty
  base_uri 'http://ip.jsontest.com'

  def test_navigate
    response = Home.get "/"
    expected = { "ip" => "108.199.226.79" }

    assert_equal expected, response.parsed_response
  end
end

