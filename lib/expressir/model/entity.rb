module Expressir
  module Model
    class Entity < ModelElement
      include Scope
      include Identifier

      attr_accessor :abstract
      attr_accessor :supertype_expression
      attr_accessor :subtype_of
      attr_accessor :attributes
      attr_accessor :unique
      attr_accessor :where
      attr_accessor :informal_propositions

      def initialize(options = {})
        @id = options[:id]
        @remarks = options.fetch(:remarks, [])
        @source = options[:source]

        @abstract = options[:abstract]
        @supertype_expression = options[:supertype_expression]
        @subtype_of = options[:subtype_of]
        @attributes = options.fetch(:attributes, [])
        @unique = options.fetch(:unique, [])
        @where = options.fetch(:where, [])
        @informal_propositions = options.fetch(:informal_propositions, [])
      end

      def children
        items = []
        items.push(*@attributes)
        items.push(*@unique)
        items.push(*@where)
        items.push(*@informal_propositions)
        items
      end
    end
  end
end