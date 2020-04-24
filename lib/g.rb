module G
  COLORS = {
    :black => Gosu::Color::BLACK,
    :blue => Gosu::Color::BLUE,
    :white => Gosu::Color::WHITE,
    :gray => Gosu::Color::GRAY,
  }

  class << self
    attr_accessor :window, :fonts
  end

  def self.init_fonts
    @fonts = {
      :large => Gosu::Font.new(window, 'Fira Mono', window.height / 35),
      :medium => Gosu::Font.new(window, 'Fira Mono', window.height / 45)
    }
  end

  def self.draw_quad(p1:, p2:, p3:, p4:, color:, z: 0)
    color = COLORS[color]
    window.draw_quad(
      p1.x, p1.y, color, p2.x, p2.y, color,
      p3.x, p3.y, color, p4.x, p4.y, color,
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

  def self.draw_text(msg:, x:, y:, z: 0, size:, color: :white)
    font = fonts[size]
    color = COLORS[color]

    font.draw_text(msg, x, y, z, 1, 1, color)
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
