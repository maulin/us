module Us
  class GameObject
    SIZE = 25

    attr_reader :name, :pos, :owner

    def initialize(data:, players:)
      @id = data['id']
      @name = data['name']
      @center = Point.new(data['cx'], data['cy'])
      @pos = Point.new(@center.x - SIZE, @center.y - SIZE)
      @owner = players.find { |p| p.id == data['owner'] }
    end

    def clicked?(pos)
      vec = Vector.new(@center, pos)
      vec.magnitude < SIZE ? true : false
    end

    def to_s
      "#{self.class.name.split("::").last}: #{name}"
    end

    def menu_type
      self.class.name.split("::").last.downcase.to_sym
    end
  end
end
