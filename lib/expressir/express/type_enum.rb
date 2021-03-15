require "expressir/express/defined_type"

module Expressir
  module Express
    class TypeEnum < DefinedType
      attr_accessor :items_array, :items, :extends, :extends_item,
        :isExtensible, :allitems, :isBuiltin

      def initialize(options = {})
        @isBuiltin = false
        @selectedBy = []

        super(options)
      end

      private

      def extract_type_attributes(document)
        if document.class == Nokogiri::XML::NodeSet
          document = document.first
        end

        @name = @options.fetch(:type_name)
        @items = document.attributes["items"]
        @items_array = items.to_s.scan(/\w+/)
        super(document)
      end
    end
  end
end
