source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use Thin as the application server
gem 'thin'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# Use Foreman for environment configuration
gem 'foreman'

# Use HAML for layout
gem 'haml-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Keep those attributes nice & clean
gem 'strip_attributes', '~> 1.2'

# Use Gravatar for user images
gem 'gravtastic'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 2.14'
end

group :development do
  gem 'query_diet', :git => 'https://github.com/dtao/query_diet.git'
end

group :test do
  gem 'debugger'
end

group :production do
  gem 'rails_12factor'
end
