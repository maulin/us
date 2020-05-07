module Us
  class Player
    attr_reader :id, :name, :color, :ring

    def initialize(data:)
      @id = data['id']
      @name = data['name']
      @color = data['color'].to_sym
      @ring = Gosu::Image.new(File.expand_path("./assets/#{color}.png"))
    end
  end
end
