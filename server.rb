require './core/loader'
require 'sinatra'
require 'json'
post '/incoming' do
  @payload = JSON.parse(request.body.read)
    all_fired_actions = []
    Listener.descendants.each do  |klass|
    klass.accepted_events.each do |event|
      if event.to_s == request.env['HTTP_X_GITHUB_EVENT']
        handler = klass.new @payload
        all_fired_actions.concat handler.fired_actions
      end
    end
  end

  if all_fired_actions.empty?
    "No actions triggered"
  else
    "Actions triggered: #{all_fired_actions.join(", ")}"
  end
end
