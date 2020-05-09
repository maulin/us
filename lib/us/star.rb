module Us
  class Star
    SIZE = 25

    attr_reader :name, :pos, :owner

    def initialize(data:, players:)
      @id = data['id']
      @name = data['name']
      @pos = Point.new(data['x'], data['y'])
      @center = Point.new(data['cx'], data['cy'])
      @owner = players.find { |p| p.id == data['owner'] }
      @ships = data['ships']
      @bottom_middle = Point.new(@center.x, @center.y + SIZE + 5)
    end

    def build_carrier
      return unless owner.credits >= Server::Game::CARRIER_COST
      Us.update_game(order: { order_object: self.class.name, object_id: @id, order: 'carrier' })
    end

    def handle_click(pos)
      vec = Vector.new(@center, pos)
      if vec.magnitude < SIZE
        Us.game.star_menu.show(star: self)
      end
    end

    def to_s
      "#{name}, POS: #{pos}"
    end

    def draw
      G.draw_text(text: @ships, pos: @bottom_middle, z: 10, size: :tiny)
    end
  end
end
