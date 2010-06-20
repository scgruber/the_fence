class Category
  include Mongoid::Document

  key :name

  field :name, :type => String
  field :kind, :type => String

end
