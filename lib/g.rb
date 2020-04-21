module G
  COLORS = {
    :white => Gosu::Color::WHITE,
    :blue => Gosu::Color::BLUE
  }

  class << self
    attr_accessor :window
  end

  def self.draw_quad(p1, p2, p3, p4, color)
    color = COLORS[color]
    window.draw_quad(
      p1.x, p1.y, color,
      p2.x, p2.y, color,
      p3.x, p3.y, color,
      p4.x, p4.y, color
    )
  end

  def self.draw_line(p1, p2, color)
    color = COLORS[color]
    window.draw_line(
      p1.x, p1.y, color,
      p2.x, p2.y, color
    )
  end

  def self.draw_text(msg, x, y, z = 0)
    text = Gosu::Image.from_text(window, msg, Gosu.default_font_name, 30)
    text.draw(x, y, z)
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
