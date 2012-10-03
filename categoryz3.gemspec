$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "categoryz3/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "categoryz3"
  s.version     = Categoryz3::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Categoryz3."
  s.description = "TODO: Description of Categoryz3."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "ffaker"
end
