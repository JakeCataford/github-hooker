class IssueTagger < Listener
  #####
  # `listen_to` specifies the event type to act on.
  # Look here for a list:
  #
  # https://developer.github.com/webhooks/
  listen_to :issues

  #####
  # Example hook action:
  #
  # Adds an 'untriaged' label to new issues that were created
  # without any labels.

  action "Add 'untriaged' label to issues with none", -> (payload) { payload["action"] == "opened" } do |payload|
    webhook = Webhook.new payload
    webhook.add_labels_to_issue "untriaged" if webhook.issue.labels.empty?
  end
end
