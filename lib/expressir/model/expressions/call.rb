module Expressir
  module Model
    module Expressions
      class Call < ModelElement
        attr_accessor :ref
        attr_accessor :parameters

        def initialize(options = {})
          @ref = options[:ref]
          @parameters = options.fetch(:parameters, [])
        end
      end
    end
  end
end