Before do
  Mongoid.master.collections.reject { |c| c.name == 'system.indexes' }.each(&:drop)
end