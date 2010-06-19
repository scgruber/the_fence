# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  config.mailer_sender = "admin@takethefence.com"

  config.http_authenticatable = false
  
  config.password_length = 6..20
  config.email_regexp = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  config.use_default_scope = true
  config.default_scope = :user
  
  config.encryptor = :bcrypt
  
  require 'devise/orm/mongoid'
end
