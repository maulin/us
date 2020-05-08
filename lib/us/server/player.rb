module Us
  module Server
    class Player
      COLORS = [:p_blue, :p_orange]

      attr_reader :id, :name, :color, :manufacturing

      def initialize(id:, name:, color:)
        @researching = 'weapons'
        @manufacturing = 1
        @id = id
        @name = name
        @color = color
        puts "GAME: #{self} created"
      end

      def to_s
        "PLAYER: #{@name} - #{@color}"
      end

      def full_resp
        basic_resp.merge({
          researching: @researching
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
