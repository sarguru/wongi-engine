module Wongi::Engine

  class BetaMemory < BetaNode
    attr_reader :tokens, :last_token

    def initialize parent
      super
      @tokens = []
    end

    def seed assignments = {}
      t = Token.new( nil, nil, assignments )
      t.node = self
      @tokens << t
    end

    def subst valuations
      token = @tokens.first
      token.delete true
      valuations.each { |variable, value| token.subst variable, value }
      self.children.each do |child|
        child.left_activate token
      end
    end

    def left_activate token, wme, assignments
      # puts "MEMORY #{@id} left-activated with #{wme}"
      t = Token.new( token, wme, assignments)
      t.node = self
      @last_token = t
      @tokens << t
      self.children.each do |child|
        if child.kind_of? BetaMemory
          child.left_activate t, nil, {}
        else
          child.left_activate t
        end
      end
    end

    # => TODO: investigate if we really need this
    #def beta_memory
    #  self
    #end

  end

end
