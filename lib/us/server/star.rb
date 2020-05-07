module Us
  module Server
    class Star
      SIZE = 25

      attr_reader :pos, :name

      def initialize(pos:, color:, name:, owner:)
        @ships = 0
        @pos = pos
        @color = color
        @name = name
        @owner = owner
        puts "GAME: #{self} created"
      end

      def to_s
        "STAR: #{@name}, POS: #{pos}"
      end

      def width
        SIZE * 2
      end

      def height
        SIZE * 2
      end

      def owned_by?(player_id:)
        @owner.id == player_id
      end

      def full_resp
        basic_resp.merge({
          sh: @ships
        })
      end

      def basic_resp
        {
          x: pos.x - SIZE,
          y: pos.y - SIZE,
          n: name,
          o: @owner.id,
          c: @color
        }
      end
    end
  end
end
