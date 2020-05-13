module Us
  class Carrier < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/carrier.png'))

    attr_reader :start

    def initialize(data:, game:)
      super
      @start = game.fetch_star(data['start'])
    end

    def draw
      owner.ring.draw(pos.x, pos.y, 20)
      SPRITE.draw(pos.x, pos.y, 30)
    end

    def show_jump_locations
      start.show_jump_locations
    end
  end
end
