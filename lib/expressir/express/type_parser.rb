require "expressir/express/type_enum"
require "expressir/express/type_select"
require "expressir/express/type_aggregate"

module Expressir
  module Express
    class TypeParser
      def initialize(options = {})
        @options = options
        @schema = options.fetch(:schema, nil)
      end

      def parse
        document = @options.fetch(:document, nil)
        extract_attributes(document) if document
      end

      def self.parse(document, schema)
        new(document: document, schema: schema).parse
      end

      private

      def extract_attributes(document)
        document_with_klass = document_with_klass(document)

        document_with_klass[:klass].parse(
          document_with_klass[:document],
          @schema,
          type_name: document_with_klass[:type_name]
        )
      end

      def document_with_klass(document)
        if !document.xpath("select").empty?
          build_type_hash(document, "select", Express::TypeSelect)

        elsif !document.xpath("enumeration").empty?
          build_type_hash(document, "enumeration", Express::TypeEnum)

        elsif !document.xpath("aggregate").empty?
          build_type_hash(document, "aggregate", Express::TypeAggregate)

        else
          { document: document, klass: Express::Type, type_name: nil }
        end
      end

      def build_type_hash(document, selector, klass)
        Hash.new.tap do |hash|
          hash[:klass] = klass
          hash[:document] = document.xpath(selector.to_s)
          hash[:type_name] = document.attributes["name"].to_s
        end
      end
    end
  end
end
