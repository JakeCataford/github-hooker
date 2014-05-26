require './core/loader'
require 'sinatra'
post '/incoming' do
    Listener.descendants.each do  |klass|
    klass.accepted_events.each do |event|
      if event.to_s == request.env['HTTP_X_GITHUB_EVENT']
        klass.new params
      end
    end
  end
    params.to_s
end
