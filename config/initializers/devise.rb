Devise.setup do |config|
  config.mailer_sender = "admin@takethefence.com"

  config.http_authenticatable = false  
  
  config.encryptor = :bcrypt
  
  require 'devise/orm/mongoid'
end
