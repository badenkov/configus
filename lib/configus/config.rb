module Configus
  class Config
    def initialize(data)
      return nil if data.nil?
      data.each do |key, value|
        if value.is_a? ::Hash
          self.define_singleton_method(key) { Config.new(value) }
        else
          self.define_singleton_method(key) { value }
        end
      end
    end
  end
end
