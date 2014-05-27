require 'octokit'
module Github
    WebhookUrl = "http://ruby-hookup.herokuapp.com"
    AccessToken = ENV['GITHUB_API_TOKEN']
    Login = ENV['GITHUB_LOGIN']
    Password = ENV['GITHUB_PASSWORD']
    Proxy = ENV['GITHUB_PROXY_URL']

    def construct_client
      options = {}
      options.merge!(access_token: AccessToken) unless AccessToken.nil?
      options.merge!(login: Login, password: Password) unless Login.nil? or Password.nil?
      options.merge!(api_endpoint: Proxy) unless Proxy.nil?
      Octokit::Client.new options
    end

    def client
      @octokit ||= construct_client
      @octokit
    end
end
