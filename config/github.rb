require 'octokit'
module Github
    AccessToken = ENV['GITHUB_API_TOKEN']
    Login = ENV['GITHUB_LOGIN']
    Password = ENV['GITHUB_PASSWORD']
    Proxy = ENV['GITHUB_PROXY_URL']

    def client
      return @octokit unless @octokit.nil?
      options = {}
      options.merge!(access_token: AccessToken) unless AccessToken.nil?
      options.merge!(login: Login, password: Password) unless Login.nil? or Password.nil?
      options.merge!(api_endpoint: Proxy) unless Proxy.nil?
      @octokit = Octokit::Client.new options
      return @octokit
    end
end
