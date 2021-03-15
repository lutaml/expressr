require "expressir/version"

require "expressir/cli"
require "expressir/config"
require "expressir/express"

module Expressir
  class Error < StandardError; end

  def self.ui
    Expressir::Cli::UI
  end

  def self.root
    File.dirname(__dir__)
  end

  def self.root_path
    @root_path ||= Pathname.new(Expressir.root)
  end

  def self.lib_path
    @lib_path ||= Expressir.root_path.join("lib", "expressir")
  end

  # Important Note:
  # Temporary - Until we cleanup the old example
  #
  def self.examples_path
    Expressir.root_path.join("original", "examples")
  end
end
