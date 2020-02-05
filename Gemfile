# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby
ruby "2.6.3"

# Rails
gem "rails", "~> 5.2.3"

# Everything Else
gem "bigdecimal", "1.3.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "pg", "~> 1.2", ">= 1.2.2"
gem "puma", "~> 3.11"
gem "swagger-docs", "~> 0.2.9"
gem "tzinfo-data"
gem "yard", "~> 0.9.20"

group :development, :test do
  gem "parallel_tests", "~> 2.29", ">= 2.29.2"
  gem "pry-byebug", "~> 3.7"
  gem "rspec-rails", "~> 3.8", ">= 3.8.2"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", "~> 0.79.0", require: false
  gem "spring"
  gem "spring-commands-parallel-tests"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner", "~> 1.7"
  gem "factory_bot", "~> 5.0", ">= 5.0.2"
  gem "faker", "~> 2.1"
  gem "shoulda-matchers", "~> 4.2"
  gem "simplecov", "~> 0.17.0", require: false
end
