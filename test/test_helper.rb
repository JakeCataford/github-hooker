ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require File.expand_path '../../server.rb', __FILE__

module TestHelper
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def send_payload(payload_name, event)
    body = File.read File.expand_path("payloads/#{payload_name}.json", File.dirname(__FILE__))
    post '/incoming', body, "HTTP_X_GITHUB_EVENT" => event
  end

  def send_issue(payload)
    send_payload(payload, 'issues')
  end

  def assert_action_called(action_name)
    assert last_response.body.include?(action_name), "Expected action '#{action_name}' was not called. Response body was: #{last_response.body}"
  end

  def assert_no_actions_triggered
    assert last_response.body.include?("No actions triggered"), "Actions were called when we expected none. Response body was: #{last_response.body}"
  end
end

