require_relative '../vector'
require_relative './map'

module Us
  module Server
    class Carrier
      SIZE = 25
      SPEED = Map::LY / 3

      attr_reader :id

      def initialize(star)
        @id = Us.gen_id
        @name = "USS - #{star.name}"
        @pos = star.pos
        @owner = star.owner
        @waypoints = []
      end

      def move
        if !@dest
          set_new_destination
        else
          pos.x += (@dest_vec.heading.x * SPEED)
          pos.y += (@dest_vec.heading.y * SPEED)

          if @dest.contains?(pos)
            @pos = @dest.center
            @dest = nil
            @dest_vec = nil
          end
        end
      end

      def set_new_destination
        return if @waypoints.empty?

        @dest = @waypoints.unshift
        puts "CARRIER: Traveling to #{@dest}"
        @dest_vec = Vector.new(center, @dest.center)
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
          x: @pos.x - SIZE,
          y: @pos.y - SIZE,
          cx: @pos.x,
          cy: @pos.y,
          name: @name,
          owner: @owner.id,
          waypoints: @waypoints.map(&:id)
        }
      end
    end
  end
end
