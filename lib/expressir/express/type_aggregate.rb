require "expressir/express/type"

module Expressir
  module Express
    class TypeAggregate < Type
      attr_accessor :rank, :dimensions
      def initialize(options = {})
        @rank = 0
        @dimensions = []
        @wheres = []
        @selectedBy = []

        super(options)
      end

      private

      def extract_type_attributes(document)
        @name = @options.fetch(:type_name, document.first.attributes["name"]).to_s
        @dimensions = document.map do |aggregate|
          Express::AggregateDimension.parse(aggregate)
        end

        @rank = @dimensions.size
        extract_builtintype_attributes(document)
      end

      def extract_builtintype_attributes(document)
        builtin_type = document.xpath("builtintype").first

        if builtin_type
          @isBuiltin = true
          @domain = builtin_type.attributes["type"].to_s
          @width = builtin_type.attributes["width"].to_s
          @fixed = builtin_type.attributes["fixed"] == "YES"
          @precision = builtin_type.attributes["precision"].to_s
        end
      end
    end
  end
end

