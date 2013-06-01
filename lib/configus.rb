require "configus/version"
require "configus/config"
require "configus/builder"

module Configus

  def self.build(environment, &block)
    b = Builder.new(environment, &block)
    Config.new(b.data)
  end
end
