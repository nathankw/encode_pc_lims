source 'https://rubygems.org'
ruby "2.6.5"

#Kaminari for pagination.
gem 'kaminari'

#Elasticsearch
# Put Elasticsearch gems after pagination gems (Kaminari) per the documentation link noted below. 
# Gem instructions from https://github.com/elastic/elasticsearch-rails.
#
#    Rubygem		Elasticsearch
#    0.1	→	1.x
#    2.x	→	2.x
#    5.x	→	5.x
#    master	→	master
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: 'master'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: 'master'

#Vue.js
gem 'vuejs-rails'

gem 'country_select'

#Add production webserver gem for Puma
gem "puma", group: :production

#rails12factor: According to https://devcenter.heroku.com/articles/rails-4-asset-pipeline:
# By default Rails 4 will not serve your assets. To enable this functionality you need to 
# go into config/application.rb and add this line:
#   config.serve_static_assets = true
# Alternatively you can achieve the same result by including the rails_12factor gem in your Gemfile:
#   gem 'rails_12factor', group: :production
gem 'rails_12factor', group: :production
gem 'aws-sdk', '~> 3'

gem 'active_model_serializers', '~> 0.9.3' 

gem "devise", ">= 4.6.0"
gem 'pundit', '~> 0.3.0'

gem 'carrierwave', '~> 1.3.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'json'
gem 'rails', '~> 4.2.1'

#gem 'sqlite3'
#Use PostgreSQL
# Don't use version 1.0.0 as this has a major bug that won't let the application start
# and isn't supported perhaps by the current version of ActiveRecord
gem 'pg', '~> 0.19.0'

# Use SCSS for stylesheets
gem 'sass-rails'

#Use Bootstrap (nathankw added)
#gem 'sprockets-rails', '>= 2.1.4'
gem 'sprockets-rails', '~> 3.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails', '~> 4.3'
gem 'simple_form', '~> 3.1.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
#Add jQuery UI
#gem 'jquery-ui-rails' #conflicts with Bootstrap

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
	#gem 'web_console' #trouble getting this to work. Maybe only in Rails 5 it works?
	#add pry-rails, which replaces the Rails console with a Pry console. Nice formatting, syntax-highlighting, ...
	gem 'pry-rails'
	gem 'rspec-rails'
end

group :test do
	gem 'capybara', '~> 2.4' #used for integration testing. 
	gem 'factory_girl_rails', '~> 4.5'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
