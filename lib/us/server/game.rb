require_relative './player'
require_relative './map'
require_relative './clock'

module Us
  module Server
    class Game
      START_STARS = 6
      START_STARS_MAX_DISTANCE = 150
      START_CREDITS = 500
      CARRIER_COST = 500
      MAX_PLAYERS = 1

      attr_accessor :stars, :carriers

      def initialize
        @id = Us.gen_id
        @clock = Clock.new
        @players = []
        @stars = []
        @map = Map.new
        @carriers = []
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
        @stars.each(&:build_ships)
      end

      def game_full?
        @players.size == MAX_PLAYERS
      end

      def player?(id:)
        @players.find { |p| p.id == id }
      end

      def add_player(name:)
        return if game_full?

        player = Player.new(name: name, color: next_player_color)
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

      def init_stars_for(player:)
        @map.init_stars_for(player: player)
      end

      def fetch_star(id:)
        @map.stars.find { |s| s.id == id }
      end

      def fetch_for(player_id:)
        {
          state: @state,
          clock: @clock.client_resp,
          carriers: carriers.map(&:client_resp),
          stars: fetch_stars_for(player_id: player_id),
          players: fetch_players_for(player_id: player_id)
        }.to_json
      end

      def to_json
        {
          id: @id,
          state: @state,
          clock: @clock.client_resp,
          stars: [],
          players: []
        }.to_json
      end

      def fetch_stars_for(player_id:)
        @stars.map do |s|
          s.owned_by?(player_id: player_id) ? s.full_resp : s.basic_resp
        end
      end

      def fetch_players_for(player_id:)
        @players.map do |p|
          p.id == player_id ? p.full_resp : p.basic_resp
        end
      end

      def execute_order(order: order)
        star = fetch_star(id: order['object_id'])
        return unless star

        case order['order']
        when 'carrier'
          star.build_carrier
        end
      end
    end
  end
end
