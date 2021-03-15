require "spec_helper"

RSpec.describe Expressir::Parser::OwlParser do
  describe ".parse" do
    it "parses the express document to owl" do
      owl_document = Expressir::Parser::OwlParser.parse(document)
      puts owl_document
    end
  end

  def document
    @document||= Expressir::Express.from_xml(
      Expressir.examples_path.join("ap233/ap233e1_arm_lf_stepmod-2010-11-12.xml")
    )
  end
end
