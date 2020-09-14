module Us
  module Server
    class Star
      SIZE = 25
      CHARS = ('A'..'Z').to_a

      attr_reader :id, :pos, :name, :owner

      def initialize(pos:, owner:)
        @id = Us.gen_id
        @pos = pos
        @name = CHARS.sample(4).join
        @owner = owner
        @industry = 1
        @ships = 0
        puts "GAME: #{self} created"
      end

      def change_owner(owner)
        @owner
      end

      def build_ships
        return if @industry == 0
        new_ships = ((@industry * (@owner.manufacturing + 5)) / Clock::CYCLE_TICKS.to_f).round(2)
        @ships += new_ships
      end

      def has_ships?
        completed_ships > 0
      end

      def completed_ships
        @ships.floor
      end

      def take_damage(damage)
        @ships -= damage
        if damage >= @ships
          @ships -= (@ships - @ships.to_i)
        else
          @ships -= damage
        end
      end

      def take_ships
        ships_to_take = completed_ships
        @ships -= ships_to_take
        ships_to_take
      end

      def to_s
        "STAR: #{id} #{name}, POS: #{pos}"
      end

      def owned_by?(player_id:)
        @owner.id == player_id
      end

      def full_resp
        basic_resp.merge({
          ships: completed_ships
        })
      end

      def basic_resp
        {
          id: @id,
          cx: pos.x,
          cy: pos.y,
          name: name,
          owner: @owner.id
        }
      end

      def contains?(pos)
        vec = Vector.new(@pos, pos)
        vec.magnitude < SIZE ? true : false
      end
    end
  end
end
