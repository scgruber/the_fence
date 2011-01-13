require 'devise'

require 'devise_pubcookie_authenticatable/strategy'
require 'devise_pubcookie_authenticatable/routes'

Devise.add_module :pubcookie_authenticatable,
  :strategy => true,
  :model => 'devise_pubcookie_authenticatable/model',
  :controller => :sessions,
  :route => :pubcookie