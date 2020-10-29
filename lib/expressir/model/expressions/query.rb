module Expressir
    module Model
      module Expressions
        class Query
          attr_accessor :id
          attr_accessor :source
          attr_accessor :expression
          attr_accessor :remarks
  
          def initialize(options = {})
            @id = options[:id]
            @source = options[:source]
            @expression = options[:expression]
            @remarks = options[:remarks]
          end
        end
      end
    end
  end