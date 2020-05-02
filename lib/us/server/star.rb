module Us
  module Server
    class Star
      SIZE = 25

      attr_reader :pos, :name

      def initialize(pos:, color:, name:, owner:)
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

      def client_resp
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
