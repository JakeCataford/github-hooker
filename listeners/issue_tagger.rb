class IssueTagger < Listener
  listen_to :issues

  on -> (payload) { payload["action"] == "opened" } do |payload|
    client = Octokit::Client.new access_token: ENV['GITHUB_API_TOKEN']
    issue = client.issue(payload["repository"]["fullname"], payload["issue"]["number"])
    if issue.labels.empty?
      client.add_labels_to_an_issue(payload["repository"]["fullname"], payload["issue"]["number"], ['untriaged'])
    end
  end
end
