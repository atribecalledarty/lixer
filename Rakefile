require "bundler/gem_tasks"
task :default => :spec

ENV["SINATRA_ENV"] ||= "development"

require_relative './bin/environment'
require 'sinatra/activerecord/rake'

task :console do
  Pry.start
end