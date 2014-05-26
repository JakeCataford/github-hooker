require './core/loader'
require 'sinatra'
require 'json'
post '/incoming' do
  @payload = JSON.parse(request.body.read)
    Listener.descendants.each do  |klass|
    klass.accepted_events.each do |event|
      if event.to_s == request.env['HTTP_X_GITHUB_EVENT']
        klass.new @payload
      end
    end
  end
  @payload
end
