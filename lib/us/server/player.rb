module Us
  module Server
    class Player
      COLORS = [:p_blue, :p_orange]

      attr_reader :id, :name, :color, :manufacturing

      def initialize(name:, color:)
        @id = Us.gen_id
        @credits = Game::START_CREDITS
        @name = name
        @color = color
        @researching = 'weapons'
        @manufacturing = 1
        puts "GAME: #{self} created"
      end

      def can_afford?(cost:)
        @credits >= cost
      end

      def deduct_credits(cost:)
        puts "deducting #{cost}"
        @credits -= cost
      end

      def to_s
        "PLAYER: #{@name} - #{@color}"
      end

      def full_resp
        basic_resp.merge({
          researching: @researching,
          credits: @credits
        })
      end

      def basic_resp
        {
          id: id,
          name: name,
          color: color
        }
      end
    end
  end
end
