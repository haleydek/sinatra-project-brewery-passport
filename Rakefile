ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

# Type `rake -T` on your command line to see the available rake tasks.

task :console do
  Pry.start
end

desc 'Show the current environment'
task :env do
  require 'sinatra'
  puts Sinatra::Application.environment
end