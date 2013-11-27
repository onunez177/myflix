source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'haml-rails'
gem 'bootstrap-sass', '2.3.2.2'
gem 'bootstrap_form'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '~> 2.2.1'

gem 'builder', '3.1.4'
gem 'coderay', '1.0.9'
gem 'bcrypt-ruby', '= 3.0.1'

gem 'carrierwave' # allows easy uploading of files
gem 'stripe' # e-commerce gem
gem 'sidekiq' # background job gem used setup email workers

gem 'unicorn' # production server
gem 'fog' # to setup access to Amazon S3 
gem 'unf' # needed for fog gem
gem 'figaro' # to manage ENV variables

gem 'jquery-rails' 

group :development do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
  gem 'letter_opener'
end

group :production do
  gem 'pg' 
  gem 'rails_12factor'
end

group :test, :development do
  gem 'rspec-rails'
  gem "shoulda-matchers", "~> 2.3.0"
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
  gem 'vcr' # gem allows us test APIs without having to hit servers every time
  gem 'webmock'
end