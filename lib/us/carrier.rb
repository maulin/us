module Us
  class Carrier
    attr_reader :pos, :owner

    def initialize(data:, players:)
      @id = data['id']
      @name = data['name']
      @pos = Point.new(data['x'], data['y'])
      @center = Point.new(data['cx'], data['cy'])
      @owner = players.find { |p| p.id == data['owner'] }
    end
  end
end
