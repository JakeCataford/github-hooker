class Webhook
  include Github
  attr_accessor :payload
  def initialize(webhook_payload = "")
    @payload = webhook_payload
  end

  def issue
    client.issue(payload["repository"]["full_name"], payload["issue"]["number"])
  end

  def repository
    payload["repository"]["full_name"]
  end

  def add_labels_to_issue *labels
    client.add_labels_to_an_issue(payload["repository"]["full_name"], payload["issue"]["number"], labels)
  end

  def create_hook(repository)
    client.create_hook(repository, "web", { url: "#{Github::WebhookUrl}/incoming", content_type: 'json'}, { events: ['*'], active: true })
  end

  ####
  # I'm kind of naked, lets fill this up with helper functions to take all of
  # that nasty hash digging out of sight.
end
