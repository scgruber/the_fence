require 'devise_pubcookie_authenticatable'

class User
  include Mongoid::Document

  devise :pubcookie_authenticatable, :rememberable, :trackable
         
  has_many_related :events, :foreign_key => :creator_id
  
  field :admin, :type => Boolean, :default => false
  
  def build_from_pubcookie_username(username)
    new(:pubcookie_username => username)
  end

end
