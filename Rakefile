begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'yard'
YARD::Rake::YardocTask.new do |t|
end

APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

task :default => ["app:spec"]
