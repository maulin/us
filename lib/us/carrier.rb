module Us
  class Carrier < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/carrier.png'))

    def draw
      owner.ring.draw(pos.x, pos.y, 20)
      SPRITE.draw(pos.x, pos.y, 30)
    end
  end
end
