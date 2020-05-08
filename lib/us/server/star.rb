module Us
  module Server
    class Star
      SIZE = 25

      attr_reader :pos, :name

      def initialize(pos:, name:, owner:)
        @industry = 1
        @ships = 0
        @pos = pos
        @name = name
        @owner = owner
        puts "GAME: #{self} created"
      end

      def build_ships
        return if @industry == 0
        new_ships = ((@industry * (@owner.manufacturing + 5)) / Clock::CYCLE_TICKS.to_f).round(2)
        @ships += new_ships
      end

      def ships
        @ships.floor
      end

      def to_s
        "STAR: #{@name}, POS: #{pos}"
      end

      def owned_by?(player_id:)
        @owner.id == player_id
      end

      def full_resp
        basic_resp.merge({
          ships: ships
        })
      end

      def basic_resp
        {
          x: pos.x - SIZE,
          y: pos.y - SIZE,
          cx: pos.x,
          cy: pos.y,
          name: name,
          owner: @owner.id,
        }
      end
    end
  end
end
