require_relative './g'
require_relative './menu'
require_relative './menu/game'
require_relative './game'

module Us
  class GameState
    TransitionError = Class.new(StandardError)

    def initialize
      unstarted
    end

    def unstarted
      @state = :unstarted
      Us.start_server
      @state_obj = Menu::Game.new
    end

    def create
      raise TransitionError unless @state == :unstarted

      @state = :created
      game_data = JSON.parse(Us.client.create_game.body)
      @state_obj = Game.new(game_data)
    end

    def handle_click(pos)
      @state_obj.handle_click(pos)
    end

    def draw
      G.window.translate(-Us.camera.pos.x, -Us.camera.pos.y) do
        G.window.scale(Us.camera.zoom, Us.camera.zoom, Us.camera.pos.x, Us.camera.pos.y) do
          @state_obj.draw
        end
      end
    end
  end
end
