ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require File.expand_path '../../server.rb', __FILE__

class Test < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_base_case
    post '/incoming', {payload: "hello world"}, "HTTP_X_GITHUB_EVENT" => "push"
    assert last_response.ok?
  end

  def test_nil_payload
    post '/incoming', nil, "HTTP_X_GITHUB_EVENT" => "push"
    assert last_response.ok?
  end

  def test_payload_with_condition
  end
end
