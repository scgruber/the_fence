class Category
  include Mongoid::Document

  field :name, :type => String
  field :kind, :type => String

  belongs_to_related :event

end
