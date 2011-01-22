class User
  include Mongoid::Document

  devise :omniauthable, :rememberable, :trackable
         
  has_many_related :events, :foreign_key => :creator_id
  
  field :admin, :type => Boolean, :default => false

  def self.find_for_pubcookie_oauth(access_token, signed_in_resource=nil)
    puts access_token.inspect    
  end  

end
