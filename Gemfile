source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# === CORE ===
gem 'bootsnap', '>= 1.1.0', require: false
gem 'mysql2',   '>= 0.3.18', '< 0.5'
gem 'puma',     '~> 3.11'
gem 'rails',    '~> 5.1.5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# === FEATURES ===
gem 'pundit'

# === API ===
gem 'jbuilder'

# === DEV & TEST ===
group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.6'
  gem 'webmock'
end

group :development do
  gem 'awesome_print'
  gem 'brakeman',                           require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop',               '~> 0.52.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker',             '~> 1.8.7'
  gem 'shoulda-matchers',  '~> 3.1'
  gem 'simplecov'
end
