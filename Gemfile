require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.1'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', :git => "git://github.com/rails/jquery-rails.git"
gem "haml"
gem "bson_ext", ">= 1.3.1"
gem "mongoid", ">= 2.4.3"
#authentication
gem "devise", ">= 2.0.0"
gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-facebook"
gem "omniauth-google"
#gem "omniauth-google-oauth2"
gem "bootstrap-sass", "~> 2.0.0"
gem "cancan", :git => "git://github.com/ryanb/cancan.git"
gem "therubyracer"
gem "kaminari"
gem "bootstrap-wysihtml5-rails"
gem 'zclip-rails'
gem "pdfkit"
gem 'newrelic_rpm'

gem "rspec-rails", ">= 2.8.1", :group => [:development, :test]

group :test do
  gem "database_cleaner", ">= 0.7.1"
  gem "mongoid-rspec", ">= 1.4.4"
  gem "factory_girl_rails", "~> 4.0"
  gem "cucumber-rails"
  gem "capybara"
  gem "capybara-webkit"
  gem "launchy", ">= 2.0.5"
end

#case HOST_OS
#  when /darwin/i
#    gem 'rb-fsevent', :group => :development
#    gem 'growl', :group => :development
#  when /linux/i
#    gem 'libnotify', :group => :development
#    gem 'rb-inotify', :group => :development
#  when /mswin|windows/i
#    gem 'rb-fchange', :group => :development
#    gem 'win32console', :group => :development
#    gem 'rb-notifu', :group => :development
#end

group :development do
  gem 'heroku_san'
  gem "haml-rails"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "guard-bundler", ">= 0.1.3"
  gem "guard-rails", ">= 0.0.3"
  gem "guard-livereload", ">= 0.3.0"
  gem "guard-rspec", ">= 0.4.3"
  gem "guard-cucumber", ">= 0.6.1"
  gem "pry"
  gem "pry-nav"
  gem "guard", ">= 0.6.2"
end