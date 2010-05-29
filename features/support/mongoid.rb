Before do
  Mongoid.master.collections.each(&:drop)
end