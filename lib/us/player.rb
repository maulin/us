module Us
  class Player
    attr_reader :id, :name, :color, :ring

    def initialize(id:, name:, color:)
      @id = id
      @name = name
      @color = color.to_sym
      @ring = Gosu::Image.new(File.expand_path("./assets/#{color}.png"))
    end
  end
end
