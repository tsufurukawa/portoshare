source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'pg'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'bcrypt'
gem 'font-awesome-sass'
gem 'bootstrap_form'
gem 'fog', require: "fog/aws/storage"
gem 'carrierwave'
gem 'mini_magick'
gem 'figaro'
gem 'omniauth'
gem 'omniauth-github'
gem 'octokit'
gem 'cocoon'
gem 'redcarpet'
gem 'pygments.rb'
gem 'kaminari'
gem 'pg_search'
gem 'unicorn'
gem 'sentry-raven'

group :assets do
  gem 'sass-rails', '~> 4.0.3'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'asset_sync'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'webmock'
  gem 'vcr'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'database_cleaner', '~> 1.3.0'
end

group :test, :development do
  gem 'pry'
  gem 'rspec-rails'
  gem 'fabrication'
  gem 'faker'
end

group :production do
  gem 'rails_12factor'
end