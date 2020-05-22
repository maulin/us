require_relative '../vector'

module Us
  module Server
    class Carrier
      SPEED = Map::LY / 3

      attr_reader :id, :pos

      def initialize(star)
        @id = Us.gen_id
        @name = "USS - #{star.name}"
        @pos = star.pos.dup
        @owner = star.owner
        @waypoints = []
        @ships = 0.0
      end

      def move
        if !@dest
          set_new_destination
        else
          @pos.x += (@dest_vec.heading.x * SPEED)
          @pos.y += (@dest_vec.heading.y * SPEED)

          if @dest.contains?(pos)
            puts "CARRIER: Reached destination - #{@dest}"
            @pos = @dest.pos.dup
            @dest_vec = nil
            do_ship_transfer
            @dest = nil
          end
        end
      end

      def do_ship_transfer
        add = @dest.take_ships
        @ships += add
        puts @ships
        puts @add
      end

      def ships
        @ships.floor
      end

      def set_new_destination
        return if @waypoints.empty?

        @dest = @waypoints.shift
        puts "CARRIER: Traveling to #{@dest}"
        @dest_vec = Vector.new(pos, @dest.pos)
        move
      end

      def update_waypoints(waypoints)
        @waypoints = []
        waypoints.each do |id|
          @waypoints << Server.game.fetch_star(id)
        end
      end

      def client_resp
        {
          id: @id,
          cx: @pos.x,
          cy: @pos.y,
          name: @name,
          owner: @owner.id,
          waypoints: @waypoints.map(&:id),
          dest: @dest&.id,
          ships: ships
        }
      end
    end
  end
end
