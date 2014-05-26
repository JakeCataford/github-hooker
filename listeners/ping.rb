class PingListener < Listener
  listen_to :ping

  on -> (payload) { true } do |payload|
    puts payload["zen"]
  end
end
