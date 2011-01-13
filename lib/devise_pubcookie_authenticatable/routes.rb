module Devise

ActionDispatch::Routing::Mapper.class_eval do
  protected

  alias_method :devise_pubcookie, :devise_session
end

end