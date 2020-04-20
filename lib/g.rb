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
end
