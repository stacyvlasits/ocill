source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#postgresql
gem 'pg'
#server
gem 'thin'

#authorization/authentication
gem 'devise'
gem 'cancan'

# WYSIWYG provided by tinymce
gem 'tinymce-rails', '~> 3.5'
gem 'tinymce-rails-imageupload', '~> 3.5.6.3'

# adding foreign keys
gem 'foreigner'
gem 'immigrant'

#gems for file upload and storage
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem 'carrierwave_direct'
gem 'sidekiq'

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# gems for forms

gem 'inherited_resources'
gem 'dynamic_form'


# Gems used only for assets and not required
# in production environments by default.
group :development do
  gem 'newrelic_rpm'
  gem 'ruby-prof'
  gem 'rails_best_practices'
  gem 'foreigner'
  gem 'immigrant'
  gem 'debugger'
  gem 'hirb'
  gem 'jist'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :test do
  gem "factory_girl_rails", "~> 4.0"
# adding 2.0.3 declaration may fix capybara-webkit issues
# per: http://stackoverflow.com/questions/15996969/capybara-webkit-page-should-have-content-not-implemented
  gem "capybara", "2.0.3"
 # gem "capybara-webkit"
  gem "guard-rspec"
  gem "launchy"
  gem "cucumber-rails"
  gem "database_cleaner"
  gem 'guard-cucumber'
end

group :development, :test do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rb-fsevent', '~> 0.9.1'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails'
  gem 'less-rails'
  gem 'font-awesome-rails'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end



# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
