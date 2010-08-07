source 'http://rubygems.org'

gem 'rails', '3.0.0.rc'

# Model
gem 'mongoid', '2.0.0.beta.16'
gem 'bson_ext'
gem 'carrierwave', '0.5.0.beta2'
gem 'rmagick'

# View
gem 'right-rails'
gem 'haml'
gem 'formtastic',    :path => File.join(File.dirname(__FILE__), '/vendor/gems/formtastic')

# Controller
gem 'devise', '1.1.rc2'
gem 'cancan'

group :development, :test do
  gem 'ruby-debug'
end

group :test do
	gem 'autotest'
  
  gem 'rspec', '2.0.0.beta.19'
	gem 'rspec-rails', '2.0.0.beta.19' 
	gem 'webrat'
  gem 'factory_girl_rails', '1.0.0'

  gem 'capybara'
  gem 'cucumber-rails'
  gem 'cucumber', '0.8.5'
  gem 'spork'
  gem 'launchy'
	
	if RUBY_PLATFORM =~ /darwin/
  	gem 'autotest-fsevent'
  	gem 'autotest-growl'
  end
end