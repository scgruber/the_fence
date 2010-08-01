# TODO: remove this when mongoid does to_param correctly
module ActionDispatch
  module Routing
    class RouteSet #:nodoc:
      class Generator #:nodoc:
        def opts
          parameterize = lambda do |name, value|
            if name == :controller
              value
            elsif value.is_a?(Array)
              value.map { |v| Rack::Mount::Utils.escape_uri(v.to_param) }.join('/')
            else
              # return nil unless param = value.to_param
              return nil unless param = value.to_param.to_s 
              param.split('/').map { |v| Rack::Mount::Utils.escape_uri(v) }.join("/")
            end
          end
          {:parameterize => parameterize}
        end
      end
    end
  end
end