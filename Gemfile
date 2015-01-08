source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.21'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#postgresql
gem 'pg'
#server
gem 'thin'

#authorization/authentication
gem 'devise'
gem 'cancan'

# WYSIWYG provided by tinymce DON'T UPDATE css will be lost.
gem 'tinymce-rails', '~> 3.5'
gem 'tinymce-rails-imageupload', '~> 3.5.6.3'


# for file upload and storage
gem 'carrierwave'
gem 'rmagick', :require => 'RMagick'
gem 'fog'
gem 'carrierwave_direct'
gem 'sidekiq'
gem 'panda', '~> 1.6.0'

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# for enhancing forms
gem 'inherited_resources'
gem 'dynamic_form'

# for heroku
gem 'mandrill-api'
gem 'newrelic_rpm'
gem 'rails_12factor'

# for LTI
gem 'ims-lti'

# for caching
gem 'memcachier'
gem 'dalli'

# for profiling Must be after pg gem
gem 'rack-mini-profiler'

#jammin' console
gem 'pry'
gem 'pry-nav'
gem 'pry-doc'
gem 'pry-rails'


# Gems used only for assets and not required
# in production environments by default.
group :development do
  gem 'awesome_print'
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
  gem 'cucumber-rails', :require => false
  gem "database_cleaner"
  gem 'guard-cucumber'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rb-fsevent', '~> 0.9.1'
end

group :assets do
  # until the lastest version of the sass gem gets fixed...
  gem 'sass', '3.2.13'  
  # gem 'sass-rails',   '~> 3.2.3'
  gem 'sass-rails',   '3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'twitter-bootstrap-rails'
  gem 'less-rails'
  gem 'font-awesome-rails'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'toastr-rails'
end
