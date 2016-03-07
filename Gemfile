source 'https://rubygems.org'
ruby '2.3.0'


gem 'rails', '4.1.9'
# enables use of rails 3.0 style attr_accessible in rails
gem 'protected_attributes'
gem 'activeresource'


#postgresql
gem 'pg'
#server
gem 'thin'

#authorization/authentication
gem 'devise'
gem 'cancan'
gem 'tinymce-rails', '4.1.6'
gem 'tinymce-rails-imageupload', '~> 4.0.0.beta'


# for file upload and storage
gem 'carrierwave'
gem 'rmagick'
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
gem 'canvas-api'
gem 'memcachier'
gem 'dalli'

# for profiling Must be after pg gem
gem 'rack-mini-profiler'

# for a jammin' console
gem 'pry'
gem 'pry-nav'
gem 'pry-doc'
gem 'pry-rails'

# for kick-ass assets
gem 'sass'
gem 'sass-rails'
gem 'coffee-rails'
gem 'twitter-bootstrap-rails', '2.2.8'
gem 'less-rails'
gem 'font-awesome-rails'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier', '>= 1.0.3'
gem 'toastr-rails'
gem 'yui-compressor'

group :development do
  gem "spring"
  gem 'awesome_print'
  gem 'ruby-prof'
  gem 'rails_best_practices'
  gem 'foreigner'
  gem 'immigrant'
  # gem 'debugger'  removed during upgrade to 4.0 due to incompatability
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