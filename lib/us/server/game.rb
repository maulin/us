require_relative './player'
require_relative './map'
require_relative './carrier'
require_relative './clock'

module Us
  module Server
    class Game
      START_STARS = 6
      START_CREDITS = 500
      START_STARS_MAX_DISTANCE = Map::LY * 6
      CARRIER_COST = 25
      MAX_PLAYERS = 2

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
        begin
          loop do
            if @state == :started
              @clock.tick
              if @clock.tick_complete?
                puts "TICK COMPLETE"
                move_carriers
                build_ships_at_stars
                @clock.increment_tick
                if @clock.cycle_complete?
                  puts "GALACTIC CYCLE COMPLETE"
                  @clock.increment_cycle
                end
              end
            end
          end
        rescue => e
          puts e.backtrace
          raise e
        end
      end

      def move_carriers
        @carriers.each(&:move)
      end

      def perform_combat(carrier:, star:)
        defender = star.owner
        agressor = carrier.owner

        defender_turns = (carrier.ships / agressor.weapons).ceil
        agressor_turns = (star.completed_ships / (defender.weapons + 1)).ceil

        if defender_turns >= agressor_turns
          # defender win
          destroy_carrier(carrier)
          remaining_turns = (defender_turns - agressor_turns) + 1
          kia_ships = star.ships - remaining_turns * agressor.weapons
          star.take_damage(kia_ships)
        else
          # agressor win
          star.change_owner(agressor)
          remaining_turns = agressor_turns - defender_turns
          kia_ships = carrier.ships - remaining_turns * defender.weapons
          carrier.take_damage(kia_ships)
        end
      end

      def destroy_carrier(carrier)
        @carriers.delete(carrier)
      end

      def build_ships_at_stars
        @stars.each(&:build_ships)
      end

      def build_carrier(id)
        star = fetch_star(id)
        return unless star.owner.can_afford?(cost: CARRIER_COST)
        carriers << Carrier.new(star)
        star.owner.deduct_credits(cost: CARRIER_COST)
      end

      def game_full?
        @players.size == MAX_PLAYERS
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

      def fetch_player(id)
        @players.find { |p| p.id == id }
      end

      def fetch_star(id)
        @stars.find { |s| s.id == id }
      end

      def fetch_carrier(id)
        @carriers.find { |c| c.id == id }
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
          players: [],
          carriers: []
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

      def execute_order(order:)
        puts "GAME: Executing #{order}"
        type = order['order']
        case type
        when 'carrier'
          star_id = order['id']
          build_carrier(star_id)
        when 'waypoints'
          carrier = fetch_carrier(order['id'])
          carrier.update_waypoints(order['waypoints'])
        end
      end

      def same_team?(obj_1, obj_2)
        obj_1.owner == obj_2.owner
      end
    end
  end
end
