require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

#task :default => :default

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty --tags ~@ignore"
end