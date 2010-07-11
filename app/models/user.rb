class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many_related :events, :foreign_key => :creator_id
  
  field :admin, :type => Boolean, :default => false

end
