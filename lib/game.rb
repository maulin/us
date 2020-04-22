require_relative './map'

class Game
  extend Forwardable

  START_STARS = 6
  STAR_MIN_DISTANCE = 10
  START_STARS_MAX_DISTANCE = 100

  attr_accessor :state

  def_delegators :@map, :move_objects

  def initialize(window)
    @map = Map.new(window.width, window.height)
  end

  def draw
    @map.draw
  end
end
