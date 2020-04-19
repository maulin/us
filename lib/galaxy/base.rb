module Galaxy
  class Base
    attr_accessor :stars

    def initialize(width, height)
      @map = Map.new(width, height)
      @stars = @map.initialize_stars
    end
  end
end
