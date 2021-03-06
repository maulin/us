require_relative '../quad'
require_relative '../point'

module Us
  module Menu
    WIDTH = Us::WIDTH * 0.20

    class Hud
      CLOCK_H = 50
      PLAYER_H = 50

      def initialize(game)
        @game = game
        init_clock
        init_players
      end

      def init_clock
        @clock_quad = Quad.new(
          Point.new(0, 0), Point.new(WIDTH, 0),
          Point.new(0, CLOCK_H), Point.new(WIDTH, CLOCK_H)
        )
      end

      def init_players
        @player_quads = []
        @avatar_width = WIDTH / Server::Game::MAX_PLAYERS

        Server::Game::MAX_PLAYERS.times do |i|
          start = @avatar_width * i
          quad = Quad.new(
            Point.new(start, CLOCK_H), Point.new(start + @avatar_width, CLOCK_H),
            Point.new(start, CLOCK_H + PLAYER_H), Point.new(start + @avatar_width, CLOCK_H + PLAYER_H),
          )
          @player_quads << quad
        end
      end

      def draw
        draw_clock
        draw_players
      end

      def draw_clock
        G.draw_quad(quad: @clock_quad, color: :blue_dark, z: 100)
        text = "Credits $#{Us.current_player.credits} #{@game.clock}"
        G.draw_text(text: text, pos: Point.new(50, 10), z: 100, size: :small)
      end

      def draw_players
        offset = @avatar_width / 3
        Server::Game::MAX_PLAYERS.times do |i|
          player = @game.players[i]
          if player
            G.draw_quad(quad: @player_quads[i], color: player.color, z: 100)
            G.draw_text(
              text: player.name[0], pos: Point.new(@avatar_width * i + offset, CLOCK_H), z: 100, size: :large
            )
          else
            G.draw_quad(quad: @player_quads[i], color: :gray, z: 100)
            G.draw_text(
              text: "?", pos: Point.new(@avatar_width * i + offset, CLOCK_H), z: 100, size: :large
            )
          end
        end
      end

      def clicked?(pos)
        @clock_quad.contains?(pos) || @player_quads.any? { |p| p.contains?(pos) }
      end

      def handle_click(pos)
        if @clock_quad.contains?(pos)
          Us.update_game
          return true
        end
        false
      end
    end
  end
end
