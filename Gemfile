source 'http://rubygems.org'

gem 'rails', '~>3.0.0'

# Model
gem 'mongoid', '2.0.0.beta.19'
gem 'bson_ext'
gem 'carrierwave', '~>0.5.1'
gem 'rmagick'

# View
gem 'right-rails'
gem 'haml'

gem 'formtastic', '~> 1.1.0'

# Controller
gem 'devise', '1.1.rc2'
gem 'cancan'

group :development, :test do
  gem 'ruby-debug19'
end

group :test do
	gem 'autotest'
  
  gem 'metric_fu'
  
  gem 'rspec', '~>2.4.0'
  gem 'rspec-rails', '~>2.4.0'
  gem 'webrat'
  gem 'factory_girl_rails', '~>1.0.0'

  gem 'capybara'
  gem 'cucumber-rails'
  gem 'cucumber', '~>0.10.0'
  gem 'spork'
  gem 'launchy'
	
	if RUBY_PLATFORM =~ /darwin/
  	gem 'autotest-fsevent'
  	gem 'autotest-growl'
  end
end