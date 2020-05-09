require_relative '../vector'

module Us
  module Server
    class Carrier
      SIZE = 25

      def initialize(star: self)
        @id = Us.gen_id
        @name = "#{star.name} - carrier"
        @pos = star.pos
        @owner = star.owner
      end

      def client_resp
        {
          id: @id,
          x: @pos.x - SIZE,
          y: @pos.y - SIZE,
          cx: @pos.x,
          cy: @pos.y,
          name: @name,
          owner: @owner.id
        }
      end
    end
  end
end
