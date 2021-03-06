module Wongi::Engine

  class SimpleAction < Action

    def initialize action = nil, *args, &block
      @action = if action.is_a? Class
        action.new *args, &block
      else
        action || block
      end
    end

    def execute token
      if @action.respond_to? :call
        @action.call token
      elsif @action.respond_to? :execute
        @action.execute token
      end
    end

  end

end
