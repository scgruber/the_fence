# Forked, waiting for pull
module Mongoid
  class Criteria
    def shift
      top = first
      @options[:skip] = (@options[:skip] || 0) + 1
      top
    end
  end
end