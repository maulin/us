require_relative '../vector'

module Us
  module Server
    class Carrier
      SIZE = 25

      attr_reader :id

      def initialize(star)
        @id = Us.gen_id
        @name = "USS - #{star.name}"
        @pos = star.pos
        @owner = star.owner
        @waypoints = []
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
