module Us
  class Player
    attr_reader :id, :name, :color, :ring, :credits

    def initialize(data:)
      @id = data['id']
      @name = data['name']
      @color = data['color'].to_sym
      @ring = Gosu::Image.new(File.expand_path("./assets/#{color}.png"))
      @credits = data['credits']
      @manufacturing = data['manufacturing']
      @hyperspace = data['hyperspace']
    end

    def hyperspace_range
      @hyperspace * Server::Map::LY * 6
    end
  end
end
