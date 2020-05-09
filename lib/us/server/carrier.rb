require_relative '../vector'

module Us
  module Server
    class Carrier
      def initialize(star: self)
        @name = "#{star.name} - #{star.carrier_count}"
        @pos = star.pos
        @owner = star.owner
      end

      def client_resp
        {
          x: pos.x,
          y: pos.y,
          name: @name,
          owner: @owner.id
        }
      end
    end
  end
end
