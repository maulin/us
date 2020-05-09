module Us
  module Server
    class Star
      SIZE = 25
      CHARS = ('A'..'Z').to_a

      attr_reader :id, :pos, :name, :owner, :carrier_count

      def initialize(pos:, owner:)
        @id = Us.gen_id
        @pos = pos
        @name = CHARS.sample(4).join
        @owner = owner
        @industry = 1
        @ships = 0
        @carrier_count = 0
        puts "GAME: #{self} created"
      end

      def build_ships
        return if @industry == 0
        new_ships = ((@industry * (@owner.manufacturing + 5)) / Clock::CYCLE_TICKS.to_f).round(2)
        @ships += new_ships
      end

      def build_carrier
        Server.game.carriers << Carrier.new(star: self)
        carrier_count += 1
      end

      def ships
        @ships.floor
      end

      def to_s
        "STAR: #{name}, POS: #{pos}"
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
          id: @id,
          x: pos.x - SIZE,
          y: pos.y - SIZE,
          cx: pos.x,
          cy: pos.y,
          name: name,
          owner: @owner.id
        }
      end
    end
  end
end
