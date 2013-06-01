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
        if block.nil?
          value = args[0]
        else
          env = Environment.new(&block)
          value = env.data
        end
        @data[key] = value
      end
    end

    def initialize(environment, &block)
      @envs = {}
      @current_environment = environment
      @envs_options = {}
      instance_eval(&block)
    end

    def env(environment, options = {}, &block)
      env = Environment.new(&block)
      @envs[environment] = env.data
      @envs_options[environment] = options
    end

    def data
      merge_parents
      @envs[@current_environment] 
    end
    
    def merge_parents
      @envs_options.each do |env, opts|
	if opts[:parent]
          @envs[env].deep_merge! @envs[opts[:parent]]
        end
      end
    end
  end
end
