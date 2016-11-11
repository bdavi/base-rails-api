ruby File.read('.ruby-version').split('-').last.strip
source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'pundit'
gem 'bcrypt'
gem 'activevalidators', '~> 4.0.0'
gem 'jsonapi-resources'
gem 'apitome', git: 'https://github.com/jejacks0n/apitome.git'
gem 'doorkeeper'
gem 'pundit-resources'
gem "sidekiq", ">= 4.1.1"
gem "sinatra", :require => nil
gem "redis-namespace", ">= 1.3.2"

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'rspec_api_documentation'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'pundit-matchers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
