module Us
  class Star
    SIZE = 25

    attr_reader :name, :pos, :owner

    def initialize(data:, players:)
      @name = data['name']
      @pos = Point.new(data['x'], data['y'])
      @center = Point.new(data['cx'], data['cy'])
      @owner = players.find { |p| p.id == data['owner'] }
    end

    def handle_click(pos)
      vec = Vector.new(@center, pos)
      puts "STAR CLICKED!" if vec.magnitude < SIZE
    end
  end
end
