class Star
  extend Forwardable

  attr_accessor :quad

  def_delegators :@quad, :nw, :ne, :se, :sw, :center

  def initialize(quad)
    @quad = quad
  end
end
