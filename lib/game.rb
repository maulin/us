require_relative './map'

class Game
  START_STARS = 6
  START_STARS_MAX_DISTANCE = 100

  attr_accessor :state

  def initialize
    @map = Map.new
  end

  def draw(camera)
    @map.draw(camera)
  end
end
