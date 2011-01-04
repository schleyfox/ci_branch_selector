require 'rubygems'
require 'sinatra'
require 'yaml'
require 'hoptoad_notifier'
require 'json'

HoptoadNotifier.configure do |config|
  config.api_key = '02f4853ea4fb9f22ce381da6df51e0a6'
end

use HoptoadNotifier::Rack
enable :raise_errors

post '/branch_selector/:name' do
  branch = JSON.load(params[:payload])['ref'] rescue nil
  halt 403 unless branch

  config = YAML.load(File.read(File.join(File.dirname(__FILE__), "projects.yml")))
  project = config[params[:name]]
  halt 404 unless project && project[branch]

  hook = project[branch]

  Net::HTTP.post_form(URI.parse(hook), {})

  "done!"
end
  
  

