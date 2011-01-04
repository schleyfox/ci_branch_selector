$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'ci_branch_selector'

use Rack::CommonLogger
run Sinatra::Application.new
