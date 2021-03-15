require "erb"

module Expressir
  module Parser
    class OwlParser
      def initialize(document, options)
        @options = options
        @document = document
        @top_class = options.fetch(:top_class, nil)
        @dublin_core = options.fetch(:dublin_core, false)
        @annotation_list = options.fetch(:annotation_list, [])
      end

      def parse
        erb_template.result(binding)
      end

      def self.parse(document, options = {})
        new(document, options).parse
      end

      private

      attr_reader :document, :dublin_core, :annotation_list, :top_class

      def erb_template
        @erb_template ||= ERB.new(template)
      end

      # @todo Multiple Schemas
      #
      # There could be multiple schemas or a direct schema object might
      # be provided as input, but that's something we will need to handle
      # in the future, and we also need to build the filename.
      #
      def schema
        @schema ||= document.schemas.first
        # require "pry"
        # binding.pry
      end

      def schema_uri
        @schema_uri ||= ["http://www.reeper.org", schema.name].join("/")
      end

      def template
        @template ||= File.read(Expressir.lib_path.join("owl", "template.xml.erb"))
      end

      def datatypes
        @datatypes ||=  Hash.new.tap do |hash|
          hash["INTEGER"] = 'http://www.w3.org/2001/XMLSchema#integer'
          hash["REAL"] = 'http://www.w3.org/2001/XMLSchema#float'
          hash["NUMBER"] = 'http://www.w3.org/2001/XMLSchema#float'
          hash["BINARY"] = 'http://www.w3.org/2001/XMLSchema#hexBinary'
          hash["BOOLEAN"] = 'http://www.w3.org/2001/XMLSchema#boolean'
          hash["LOGICAL"] = 'http://www.w3.org/2001/XMLSchema#boolean'
          hash["STRING"] = 'http://www.w3.org/2001/XMLSchema#string'
          hash["LIST"] = "http://www.w3.org/1999/02/22-rdf-syntax-ns#List"
        end
      end

      def annotations
        annotation_list.map do |tag, value|
          if value && value != ""
            "<#{tag} rdf:datatype=\"http://www.w3.org/2001/XMLSchema#string\">#{value}</#{tag}>"
          end
        end
      end
    end
  end
end
