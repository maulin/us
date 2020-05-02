require_relative '../vector'

module Us
  module Server
    class Carrier
      def initialize(name, pos)
        @name = name
        @pos = pos
      end

      def travel(quad)
        @dest = quad
        @dest_vec = Vector.new(@pos, @dest.center)
      end

      def move
        return unless @dest

        @pos.x += (@dest_vec.heading.x * Map::LY)
        @pos.y += (@dest_vec.heading.y * Map::LY)

        if @dest.contains?(@pos)
          @pos = @dest.center
          @dest = nil
        end
      end
    end
  end
end
