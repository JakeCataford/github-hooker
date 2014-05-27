hookup :nail_care:
=============

[![Status](https://travis-ci.org/JakeCataford/hookup.svg)](https://travis-ci.org/JakeCataford/hookup)


An easily extendable Sinatra application for handling Github webhooks.

Installation
-----

Fork, Clone your fork, `bundle install`, then run `bx rackup`. You will need a forwarding service like [ngrok](https://ngrok.com/) or [forward](https://forwardhq.com/) to recieve webhooks on localhost.

Usage
----

hookup is designed to be very easily extendable for whatever chores you might want to do on your repository.

Set up your github client in `config/github` by either exporting the environment variables or change them to something more familiar:

```Ruby
module Github
    AccessToken = ENV['GITHUB_API_TOKEN']
    Login = ENV['GITHUB_LOGIN']
    Password = ENV['GITHUB_PASSWORD']
    Proxy = ENV['GITHUB_PROXY_URL']

    def client
      options = {}
      options.merge!(access_token: AccessToken) unless AccessToken.nil?
      options.merge!(login: Login, password: Password) unless Login.nil? or Password.nil?
      options.merge!(api_endpoint: Proxy) unless Proxy.nil?
      Octokit::Client.new options
    end
end
```

Create classes in `listeners/` that extend `Listener`. include a `listen_to :whatever` call at the top, then start defining actions.

An action is something that can happen when a webhook of the type defined by `listen_to` is received. It has three parameters. The first is a descriptive name, explaining what this action is trying to do. The next is a lambda that returns true or false, treat it like an 'if' statement that defines the condition on which to run this action. Finally, there is a block that is the action callback. 

Here's an example:

```Ruby
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
```

It is recommended to add to `lib/webhook.rb` to hide all of the webhook hash digging and commit your changes so others can benefit. (I'm too lazy to wrap the whole github api right now :sleeping:)

Deployment
-----

Deploy to Heroku, should 'just work'.
One small thing to note is that a sleeping heroku dyno might miss webhooks, so you can add the newrelic plugin to keep it alive.



