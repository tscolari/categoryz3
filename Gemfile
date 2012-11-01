source "http://rubygems.org"

# Declare your gem's dependencies in categoryz3.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

group :test, :development do
  platforms :jruby do
    gem 'jdbc-sqlite3'
    gem 'activerecord-jdbc-adapter'
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'jruby-openssl'
  end

  platforms :ruby do
    gem 'sqlite3'
  end

  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

gem 'debugger'
# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
