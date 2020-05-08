require_relative './player'
require_relative './map'
require_relative './clock'

module Us
  module Server
    class Game
      START_STARS = 6
      START_STARS_MAX_DISTANCE = 150
      MAX_PLAYERS = 1

      def initialize
        @clock = Clock.new
        @players = []
        @map = Map.new
        @state = :unstarted

        puts "GAME: game #{@id} initialized"
      end

      def run
        loop do
          if @state == :started
            @clock.tick
            if @clock.tick_complete?
              puts "TICK COMPLETE"
              build_ships_at_stars
              @clock.increment_tick
              if @clock.cycle_complete?
                puts "GALACTIC CYCLE COMPLETE"
                @clock.increment_cycle
              end
            end
          end
        end
      end

      def build_ships_at_stars
        @map.stars.each(&:build_ships)
      end

      def game_full?
        @players.size == MAX_PLAYERS
      end

      def player?(id:)
        @players.find { |p| p.id == id }
      end

      def add_player(name:)
        return if game_full?

        player_id = @players.count + 1
        player = Player.new(id: next_player_id, name: name, color: next_player_color)
        @players << player
        init_stars_for(player: player)
        start if game_full?
        player
      end

      def start
        @clock.start
        @state = :started
        puts 'GAME: Starting!'
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

      def fetch_for(player_id:)
        {
          state: @state,
          clock: @clock.client_resp,
          stars: fetch_stars_for(player_id: player_id),
          players: fetch_players_for(player_id: player_id)
        }.to_json
      end

      def to_json
        {
          state: @state,
          clock: @clock.client_resp,
          stars: [],
          players: []
        }.to_json
      end

      def fetch_stars_for(player_id:)
        @map.stars.map do |s|
          s.owned_by?(player_id: player_id) ? s.full_resp : s.basic_resp
        end
      end

      def fetch_players_for(player_id:)
        @players.map do |p|
          p.id == player_id ? p.full_resp : p.basic_resp
        end
      end
    end
  end
end
