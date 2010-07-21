Devise.setup do |config|
  config.mailer_sender = "admin@takethefence.com"

  config.http_authenticatable = false

  config.use_default_scope = true
  config.default_scope = :user
  
  config.encryptor = :bcrypt
  
  require 'devise/orm/mongoid'
end
