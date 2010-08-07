Rspec.configure do |config|
  config.before(:each) do
      Mongoid.master.collections.reject { |c| c.name == 'system.indexes' }.each(&:drop)
  end
end