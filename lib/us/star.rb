module Us
  class Star
    SIZE = 25

    attr_reader :name, :pos, :owner

    def initialize(data:, players:)
      @name = data['name']
      @pos = Point.new(data['x'], data['y'])
      @center = Point.new(data['cx'], data['cy'])
      @owner = players.find { |p| p.id == data['owner'] }
      @ships = data['ships']
      @bottom_middle = Point.new(@center.x, @center.y + SIZE + 5)
    end

    def handle_click(pos)
      vec = Vector.new(@center, pos)
      puts "STAR CLICKED!" if vec.magnitude < SIZE
    end

    def draw
      G.draw_text(text: @ships, pos: @bottom_middle, z: 10, size: :tiny)
    end
  end
end
