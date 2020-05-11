module Us
  class Star
    SIZE = 25

    attr_reader :name, :pos, :owner

    def initialize(data:, players:)
      @id = data['id']
      @name = data['name']
      @center = Point.new(data['cx'], data['cy'])
      @pos = Point.new(@center.x - SIZE, @center.y - SIZE)
      @owner = players.find { |p| p.id == data['owner'] }
      @ships = data['ships']
      @bottom_middle = Point.new(@center.x, @center.y + SIZE + 5)
      @show_rings = false
    end

    def build_carrier
      return unless owner.credits >= Server::Game::CARRIER_COST
      Us.update_game(params: { order: ['carrier', @id] })
    end

    def handle_click(pos)
      @show_rings = false
      vec = Vector.new(@center, pos)
      if vec.magnitude < SIZE
        Us.game.star_menu.show(star: self)
        @show_rings = true
      end
    end

    def to_s
      "#{name}, POS: #{pos}"
    end

    def draw_rings
      r = owner.hyperspace_range

      0.step(360, 10) do |i|
        p1 = Point.new(@center.x + Gosu.offset_x(i, r), @center.y + Gosu.offset_y(i, r))
        p2 = Point.new(@center.x + Gosu.offset_x(i + 10, r), @center.y + Gosu.offset_y(i + 10, r))

        G.draw_line(p1: p1, p2: p2, color: :gray, z: 10)
      end
    end

    def draw
      draw_rings if @show_rings
      G.draw_text(text: @ships, pos: @bottom_middle, z: 10, size: :tiny)
    end
  end
end
