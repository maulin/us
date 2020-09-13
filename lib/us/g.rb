require_relative './vector'

module G
  COLORS = {
    :black => Gosu::Color::BLACK,
    :blue_dark => Gosu::Color.new(26,28,68),
    :blue_light => Gosu::Color.new(89,97,187),
    :blue_middle => Gosu::Color.new(44,50,115),
    :gray => Gosu::Color::GRAY,
    :hyperspace => Gosu::Color.new(168, 0, 223),
    :p_blue => Gosu::Color::BLUE,
    :p_orange => Gosu::Color.new(223,95,0),
    :white => Gosu::Color::WHITE
  }

  FONT_SIZES = {
    :tiny => Gosu::Font.new(15, name: 'Fira Mono'),
    :small => Gosu::Font.new(25, name: 'Fira Mono'),
    :medium => Gosu::Font.new(35, name: 'Fira Mono'),
    :large => Gosu::Font.new(45, name: 'Fira Mono')
  }

  class << self
    attr_accessor :window, :camera
  end

  def self.untranslate_and_zoom(pos)
    pos.x -=  camera.pos.x
    pos.y -=  camera.pos.y
    v = Us::Vector.new(pos, camera.center)
    pos.x = camera.center.x - v.x / camera.zoom
    pos.y = camera.center.y - v.y / camera.zoom
    pos
  end

  def self.draw_with_camera
    window.translate(camera.pos.x, camera.pos.y) do
      window.scale(camera.zoom, camera.zoom, camera.center.x, camera.center.y) do
        yield
      end
    end
  end

  def self.draw_rect(x:, y:, w:, h:, color:, z:)
    color = COLORS[color]
    window.draw_rect(x, y, w, h, color, z)
  end

  def self.draw_quad(quad:, color:, z: 0)
    color = COLORS[color]
    window.draw_quad(
      quad.p1.x, quad.p1.y, color, quad.p2.x, quad.p2.y, color,
      quad.p3.x, quad.p3.y, color, quad.p4.x, quad.p4.y, color,
      z
    )
  end

  def self.draw_line(p1:, p2:, z:, color:)
    color = COLORS[color]
    window.draw_line(
      p1.x, p1.y, color,
      p2.x, p2.y, color,
      z
    )
  end

  def self.image_from_text(text:, size:, options: {})
    size = FONT_SIZES[size].height
    { font: 'Fira Mono' }.merge(options)

    Gosu::Image.from_text(text, size, options)
  end

  def self.draw_img(img:, pos:, z: 0, color: :white)
    color = COLORS[color]

    img.draw(pos.x, pos.y, z, 1, 1, color)
  end

  def self.draw_text(text:, pos:, z:, size:, color: :white)
    color = COLORS[color]
    font = FONT_SIZES[size]
    font.draw_text(text, pos.x, pos.y, z, 1, 1, color)
  end

  def self.text_width(text:, size:)
    font = FONT_SIZES[size]
    font.text_width(text)
  end

  def self.draw_triangle(p1, p2, p3, color)
    color = COLORS[color]
    window.draw_triangle(
      p1.x, p1.y, color,
      p2.x, p2.y, color,
      p3.x, p3.y, color
    )
  end
end
