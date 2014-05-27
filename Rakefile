require 'rake/testtask'
require './core/loader'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end

task :default => [:test]
desc "Create a webhook on a repository"
task "hookup", :repo_name do |t, args|
  repo_name = args[:repo_name]
  webhook = Webhook.new
  webhook.create_hook(repo_name)
end
