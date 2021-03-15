require "spec_helper"

RSpec.describe "Expressir" do
  describe "express-to-owl" do
    it "convert express to owl system" do
      command = %W(express-to-owl #{sample_file})
      output = capture_stdout { Expressir::Cli.start(command) }

      puts output
    end
  end

  def sample_file
    @sample_file ||= Expressir.root_path.join(
      "original", "examples", "ap233", "ap233e1_arm_lf_stepmod-2010-11-12.xml"
    )
  end
end
