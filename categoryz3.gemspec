$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "categoryz3/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "categoryz3"
  s.version     = Categoryz3::VERSION
  s.authors     = ["Tiago Scolari"]
  s.email       = ["tscolari@gmail.com"]
  s.homepage    = "https://github.com/tscolari/categoryz3"
  s.summary     = "Simple categorization to ActiveRecord models."
  s.description = "Works like a simple tagging system, but instead of tags it has categories, and categories may have an ilimited level of subcategories."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.2.0"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "ffaker"
end
