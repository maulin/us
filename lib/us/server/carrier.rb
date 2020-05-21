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
            @dest = nil
            @dest_vec = nil
          end
        end
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
          dest: @dest&.id
        }
      end
    end
  end
end
