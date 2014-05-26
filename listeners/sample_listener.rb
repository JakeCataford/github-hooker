class SampleListener < Listener
  listen_to :push

  on -> (payload) { not payload.empty? } do |payload|
    true
  end

  on -> (payload) { payload.empty? } do |payload|
    true
  end

  on -> (payload) { payload["ref"] == "refs/heads/test" } do
    true
  end
end
