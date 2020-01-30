source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby
ruby '2.6.3'

# Rails
gem 'rails', '~> 5.2.3'

# Everything Else
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg', '~> 1.1', '>= 1.1.4'
gem 'puma', '~> 3.11'
gem 'sqlite3'
gem 'swagger-docs', '~> 0.2.9'
gem 'yard', '~> 0.9.20'

group :development, :test do
  gem 'pry-byebug', '~> 3.7'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'parallel_tests', '~> 2.29', '>= 2.29.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.7'
  gem 'factory_bot', '~> 5.0', '>= 5.0.2'
  gem 'faker', '~> 2.1'
  gem 'shoulda-matchers', '~> 4.2'
  gem 'simplecov', '~> 0.17.0', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
