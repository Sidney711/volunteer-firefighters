source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "rails", "~> 7.1.3.2"
gem "sprockets-rails", "~> 3.4.2"
gem "puma", "~> 6.4.2"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'ransack', "~> 4.1.1"
gem 'kaminari', "~> 1.2.2"
gem 'simple_form', "~> 5.3"
gem 'simple_form-tailwind', "~> 0.1.1"
gem "importmap-rails", "~> 2.0.1"
gem "tailwindcss-rails", "~> 2.3.0"
gem "pg", "~> 1.5.6"
gem "rodauth-rails", "~> 1.13.0"
gem 'jsonapi-resources', "~> 0.10.7"
gem 'rails-patterns', "~> 0.11.0"
gem 'validates_timeliness', '~> 7.0.0.beta2'
gem 'bcrypt'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.1.2'
  gem 'shoulda-matchers', '~> 6.2.0'
  gem 'factory_bot_rails', '~> 6.4.3'
  gem 'faker', '~> 3.3.0'
  gem 'rswag', "~> 2.13.0"
end

group :development do
  gem "web-console", '~> 4.2.1'
  gem 'foreman', '~> 0.87.2'
end

group :test do
  gem 'database_cleaner', '~> 2.0.2'
end