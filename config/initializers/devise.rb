Devise.setup do |config|
  config.mailer_sender = "admin@takethefence.com"

  config.http_authenticatable = false  
  
  config.omniauth :pubcookie, :login_server => 'webiso.andrew.cmu.edu', :host => 'secure.takethefence.com', :appid => 'fence',
                              :keyfile => Rails.root + 'etc/pubcookie.key', :granting_cert => Rails.root + 'etc/pubcookie.crt'
  
  config.encryptor = :bcrypt
  
  require 'devise/orm/mongoid'
end
