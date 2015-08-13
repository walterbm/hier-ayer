source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Used to vizualize the schema
gem 'erd'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use for authentication
gem 'devise' 

# Allows us to hide keys
gem 'figaro'

# Use Paperclip to upload media files
gem 'paperclip'

# Use AWS to move Paperclip files to s3 storage
gem 'aws-sdk', '< 2.0'

# Use Font Awesome for web-icons
gem "font-awesome-rails"

# Postgres Database
gem 'pg'

# Used for async content push to client
gem 'pusher'

gem 'omniauth'

gem 'omniauth-instagram'

gem 'omniauth-twitter'


# Geocode Latitude and Longitude
gem 'geocoder'

# Enables AJAX file uploads
gem 'remotipart', '~> 1.2'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'database_cleaner'
  gem 'pry'
  gem 'guard-rspec', require: false
  gem 'thin'
end

group :production do
  gem 'google-analytics-rails'
  gem 'rails_12factor'
end

gem 'bootstrap-sass', '~> 3.1.1'