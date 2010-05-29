class Location
  include Mongoid::Document
  
  field :name, :type => String
  field :address, :type => String
  field :description, :type => String
  
  key :name

  belongs_to_related :event
end
