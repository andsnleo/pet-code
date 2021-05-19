source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2.2'
gem 'sqlite3', '~> 1.4.1'

group :development, :test do
  gem 'pry', '~> 0.12.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 3.8.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails', '~> 5.0.1'
  gem 'shoulda-matchers', '~> 4.0.1'
end

gem 'tzinfo-data', '~> 1.2.5', platforms: %i[mingw mswin x64_mingw jruby]
