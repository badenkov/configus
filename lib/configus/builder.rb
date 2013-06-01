module Configus
  class Builder

    class Environment < BasicObject
      attr_reader :data
      def initialize(&block)
        @data = {}
        instance_eval(&block)
      end
      def method_missing(meth, *args, &block)
        key = meth.to_sym
        value = args[0]
        @data[key] = value
      end
    end

    def initialize(environment, &block)
      @envs = {}
      @current_environment = environment
      instance_eval(&block)
    end

    def env(environment, &block)
      env = Environment.new(&block)
      @envs[environment] = env.data
    end

    def data
      @envs[@current_environment]
    end
  end
end