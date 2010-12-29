Devise::Schema.class_eval do
  def pubcookie_authenticatable
    if respond_to?(:apply_devise_schema)
      apply_devise_schema :pubcookie_username, String
    else
      apply_schema :pubcookie_username, String
    end
  end
end