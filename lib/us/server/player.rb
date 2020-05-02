module Us
  module Server
    class Player
      COLORS = [:blue, :yellow]

      attr_reader :id, :name, :color

      def initialize(id:, name:, color:)
        @id = id
        @name = name
        @color = color
        puts "GAME: #{self} created"
      end

      def to_s
        "PLAYER: #{@name} - #{@color}"
      end
    end
  end
end
