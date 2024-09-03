source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.1'

gem 'rails', '6.1.7.8'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'mutex_m', '~> 0.2.0'
gem 'base64', '~> 0.2.0'
gem 'bigdecimal', '~> 3.1'
gem 'drb', '~> 2.2'
gem 'json', '~> 2.7'
gem 'rest-client', '~> 2.1'
gem 'rufus-scheduler', '~> 3.9'
gem 'sequel', '~> 5.84'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 6.1'
  gem 'dotenv', '~> 3.1'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring', '~> 4.2'
end

group :test do
  gem 'database_cleaner', '~> 2.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
