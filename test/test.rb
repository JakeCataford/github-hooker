ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require File.expand_path '../../server.rb', __FILE__

class Test < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_sample_listener
    post '/incoming', {payload: "hello world"}, "HTTP_X_GITHUB_EVENT" => "push"
  end
end
