Devise::Schema.class_eval do
  def pubcookie_authenticatable
    apply_devise_schema :pubcookie_username, String
  end
end