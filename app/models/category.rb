class Category
  include Mongoid::Document

  field :name, :type => String
  field :type, :type => String

  belongs_to_related :event

end
