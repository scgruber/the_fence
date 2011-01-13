require 'devise/strategies/base'
require 'rack/pubcookie'

base_class = begin
  Devise::Strategies::Authenticatable
rescue
  Devise::Strategies::Base
end

class Devise::Strategies::PubcookieAuthenticatable < base_class

  def valid?
    # valid_mapping? && ( pubcookie_response? || pubcookie_user_param? )
    true
  end

  def authenticate!
    if pubcookie_response
      handle_response!
    else
      opts = { :return_to => "https://secure.takethefence.com/" }
      custom! [401, {Rack::Pubcookie::Auth::AUTHENTICATE_HEADER => Rack::Pubcookie::Auth.build_header(opts)}, "Sign in with Pubcookie"]
    end
  end

  protected
  
  def handle_response!

    case pubcookie_response.status
    when :success
      resource = find_resource || build_resource
      
      if resource
        success!(resource)
      else
        fail! "This Pubcookie username is not associated with any registered user"
      end
      
    when :failure
      fail! "Pubcookie authentication failed"
    else
      puts "nonna dese"
    end
  end
  
  def pubcookie_response?
    !!pubcookie_response
  end
  
  def pubcookie_response
    env[Rack::Pubcookie::Auth::RESPONSE]
  end
  
  def valid_mapping?
     mapping.to.respond_to?(:find_by_pubcookie_username)
   end
   
   def pubcookie_user_param?
     params[scope].try(:[], 'pubcookie_user').present?
   end
  
  def find_resource
    mapping.to.find_by_pubcookie_username(pubcookie_response.pubcookie_username)
  end
  
  def build_resource
puts "try build"
    if mapping.to.respond_to?(:build_from_pubcookie_username)
puts "can build"
      mapping.to.build_from_pubcookie_username(pubcookie_response.pubcookie_username)
    end
  end
  
  def return_url
    return_to = URI.parse(request.url)
    scope_params = params[scope].inject({}) do |return_params, pair|
      param, value = pair
      return_params["#{scope}[#{param}]"] = value
      return_params
    end
    return_to.query = Rack::Utils.build_query(scope_params)
    return_to.to_s
  end

end

Warden::Strategies.add :pubcookie_authenticatable, Devise::Strategies::PubcookieAuthenticatable
