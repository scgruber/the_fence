class Category
  include Mongoid::Document

  key :name

  field :name, :type => String
  field :kind, :type => String
  
  index :name
  
  references_many :events, :stored_as => :array, :inverse_of => :categories
  
  scope :noun, where(:kind => 'noun').ascending(:name)
  scope :adjective, where(:kind => 'adjective').ascending(:name)

end
