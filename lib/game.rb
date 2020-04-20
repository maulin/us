class Game
  attr_accessor :state

  def initialize(window)
    @galaxy = Galaxy::Base.new(window.width, window.height)
    @map = @galaxy.map
    @state = :unstarted
  end

  def draw
    @map.draw
    @galaxy.draw
    @state = :started
  end
end
