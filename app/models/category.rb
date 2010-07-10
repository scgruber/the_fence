class Category
  include Mongoid::Document

  key :name

  field :name, :type => String
  field :kind, :type => String
  
  scope :noun, where(:kind => 'noun')
  scope :adjective, where(:kind => 'adjective')

end
