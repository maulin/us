module G
  class << self
    attr_accessor :window
  end

  def self.draw_quad(*attrs)
    window.draw_quad(*attrs)
  end

  def self.draw_line(*attrs)
    window.draw_line(*attrs)
  end

  def self.draw_text(msg, x, y, z = 0)
    text = Gosu::Image.from_text(window, msg, Gosu.default_font_name, 30)
    text.draw(x, y, z)
  end

  def self.draw_triangle(*attrs)
    window.draw_triangle(*attrs)
  end
end
