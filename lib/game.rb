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
    if @menu
      pos = Point.new(x, y)
      @menu.handle_click(pos)
    else
      translated_x = x + @camera.pos.x
      translated_y = y + @camera.pos.y

      pos = Point.new(translated_x, translated_y)
      object = @map.object_clicked_at(pos)
      @menu = Menu.create_for(object, self) if object
    end
  end

  def close_menu
    @menu = nil
  end
end
