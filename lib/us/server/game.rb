require_relative './player'
require_relative './map'
require_relative './clock'

module Us
  module Server
    class Game
      START_STARS = 6
      START_STARS_MAX_DISTANCE = 150

      def initialize
        @clock = Clock.new
        @players = []
        @map = Map.new

        puts "GAME: game #{@id} initialized"
        add_player(name: Us.current_user)
      end

      def run
        loop do
          @clock.tick
          if @clock.produce?
            production
            @clock.increment
          end
        end
      end

      def production
        puts "GAME: production cycle complete"
      end

      def add_player(name:)
        return if @players.size == @max_players

        player_id = @players.count + 1
        player = Player.new(id: next_player_id, name: name, color: next_player_color)
        @players << player
        init_stars_for(player: player)
      end

      def next_player_color
        (Player::COLORS - @players.map(&:color)).sample
      end

      def next_player_id
        @players.count + 1
      end

      def init_stars_for(player:)
        @map.init_stars_for(player: player)
      end

      def to_json
        {
          clock: @clock.client_resp,
          stars: @map.stars.map(&:client_resp),
          players: @players.map(&:client_resp)
        }.to_json
      end
    end
  end
end
