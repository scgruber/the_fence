require 'devise/strategies/base'
require 'rack/pubcookie'

base_class = begin
  Devise::Strategies::Authenticatable
rescue
  Devise::Strategies::Base
end

class Devise::Strategies::PubcookieAuthenticatable < base_class

  def authenticate!
    pass
  end

  protected

end

Warden::Strategies.add :pubcookie_authenticatable, Devise::Strategies::PubcookieAuthenticatable