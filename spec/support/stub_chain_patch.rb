# TODO: remove when implemented in trunk

module RSpec
  module Mocks
    module Methods
      def stub_chain(*methods)
        if methods.length > 1
          if matching_stub = __mock_proxy.send(:find_matching_method_stub, methods[0])
            methods.shift
            matching_stub.send(:invoke_return_block, nil, nil).stub_chain(*methods)
          else
            next_in_chain = Object.new
            stub!(methods.shift) {next_in_chain}
            next_in_chain.stub_chain(*methods)
          end
        else
          stub!(methods.shift)
        end
      end
    end
  end
end