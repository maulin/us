require_relative './map'
require_relative './menu'

class Game
  START_STARS = 6
  START_STARS_MAX_DISTANCE = 100

  attr_accessor :state

  def initialize(camera)
    @map = Map.new
    @camera = camera
  end

  def draw(camera)
    @menu.draw if @menu
    G.window.translate(-camera.pos.x, -camera.pos.y) do
      G.window.scale(camera.zoom, camera.zoom, camera.pos.x, camera.pos.y) do
        @map.draw(camera)
      end
    end
  end

  def handle_click(x, y)
    pos = Point.new(x, y)
    pp pos

    if @menu && @menu.clicked?(pos)
      @menu.handle_click(pos)
    else
      close_menu
      pos.x += @camera.pos.x
      pos.y += @camera.pos.y

      object = @map.object_clicked_at(pos)
      @menu = Menu.create_for(object, self) if object
    end
  end

  def close_menu
    @menu = nil if @menu
  end
end
