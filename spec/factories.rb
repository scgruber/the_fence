Factory.define :event do |e|
  e.name { |n| "Event#{n}" }
  e.description "Description"
  e.association :location
  e.start "9/9/09"
  e.finish "10/10/10"
  e.image Rack::Test::UploadedFile.new(File.dirname(__FILE__) + '/fixtures/poster.gif', 'image/gif')
end

Factory.define :category do |c|
  c.name "Category"
  c.kind "Noun"
end

Factory.define :location do |l|
  l.name { |n| "Place#{n}" }
end