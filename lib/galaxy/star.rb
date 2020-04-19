module Galaxy
  class Star
    extend Forwardable

    attr_accessor :quad

    def_delegators :@quad, :nw, :ne, :se, :sw

    def initialize(quad)
      @quad = quad
    end
  end
end
