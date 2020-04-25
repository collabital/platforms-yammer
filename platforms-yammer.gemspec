$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "platforms/yammer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "platforms-yammer"
  spec.version     = Platforms::Yammer::VERSION
  spec.authors     = ["Benjamin Elias"]
  spec.email       = ["12136262+collabital@users.noreply.github.com"]
  spec.homepage    = "https://www.collabital.com"
  spec.summary     = "Authentication and API integration with Yammer"
  spec.description = "Authentication with OmniAuth, API integration"
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0", ">= 6.0.2.1"
  spec.add_dependency "platforms-core", ">= 0.1"
  spec.add_dependency "omniauth", ">= 1.0"
  spec.add_dependency "omniauth-yammer", ">= 0.2.0"
  spec.add_dependency "faraday", ">= 1.0.0"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency 'sqlite3'
  # See https://github.com/rspec/rspec-rails/issues/2177#issuecomment-536738883
  # which can now be ignored with the release of rspec-rails ~> 4.0
  spec.add_development_dependency 'rspec-rails', ">= 4.0"
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'generator_spec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'yard-activerecord'
end
