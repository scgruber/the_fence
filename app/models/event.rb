class Event
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String
  field :start, :type => Time
  field :finish, :type => Time
  field :featured, :type => Boolean
  
  has_many_related :categories
  has_many_related :locations
end
