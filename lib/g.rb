module G
  COLORS = {
    :black => Gosu::Color::BLACK,
    :blue => Gosu::Color::BLUE,
    :white => Gosu::Color::WHITE,
    :gray => Gosu::Color::GRAY,
  }

  FONT_SIZES = {
    :small => 20,
    :medium => 35
  }

  class << self
    attr_accessor :window, :fonts
  end

  def self.draw_quad(quad:, color:, z: 0)
    color = COLORS[color]
    window.draw_quad(
      quad.p1.x, quad.p1.y, color, quad.p2.x, quad.p2.y, color,
      quad.p3.x, quad.p3.y, color, quad.p4.x, quad.p4.y, color,
      z
    )
  end

  def self.draw_line(p1, p2, color)
    color = COLORS[color]
    window.draw_line(
      p1.x, p1.y, color,
      p2.x, p2.y, color
    )
  end

  def self.image_from_text(text:, size:, options: {})
    size = FONT_SIZES[size]
    { font: 'Fira Mono' }.merge(options)

    Gosu::Image.from_text(text, size, options)
  end

  def self.draw_img(img:, pos:, z: 0, color: :white)
    color = COLORS[color]

    img.draw(pos.x, pos.y, z, 1, 1, color)
  end

  def self.draw_text(text:, pos:, z:, size:, color: :white)
    color = COLORS[color]
    font = Gosu::Font.new(window, 'Fira Mono', FONT_SIZES[size])
    font.draw_text(text, pos.x, pos.y, z, 1, 1, color)
  end


  def self.text_width(text:, size:)
    font = Gosu::Font.new(window, 'Fira Mono', FONT_SIZES[size])
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
