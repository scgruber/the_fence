# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Pubcookie::Auth, 'webiso.andrew.cmu.edu', 'secure.takethefence.com', 'fence', Rails.root + "etc/pubcookie.key", Rails.root + "etc/pubcookie.crt"

run Fence::Application
