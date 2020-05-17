require_relative '../vector'

module Us
  module Server
    class Carrier
      SIZE = 25

      def initialize(star)
        @id = Us.gen_id
        @name = "USS - #{star.name}"
        @pos = star.pos
        @owner = star.owner
        @start = star
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
          start: @start.id
        }
      end
    end
  end
end
