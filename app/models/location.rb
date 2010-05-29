class Location
  include Mongoid::Document
  
  field :name, :type => String
  field :address, :type => String
  field :description, :type => String

  # Until HABTM support comes to Mongoid
  # belongs_to_related :event
end
