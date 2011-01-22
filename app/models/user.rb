class User
  include Mongoid::Document

  devise :omniauthable, :trackable
         
  has_many_related :events, :foreign_key => :creator_id
  
  field :admin, :type => Boolean, :default => false
  field :email, :type => String

 def self.find_for_pubcookie_oauth(access_token, signed_in_resource=nil)
  data = access_token['extra']['user_hash']
  if user = User.find_by_email(data["name"])
    user
  else
    User.create!(:email => data["name"]) 
  end
end 

end
