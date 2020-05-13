module Us
  class GameObject
    SIZE = 25

    attr_reader :id, :name, :pos, :owner, :game
    attr_accessor :selected

    def initialize(data:, game:)
      @id = data['id']
      @name = data['name']
      @center = Point.new(data['cx'], data['cy'])
      @pos = Point.new(@center.x - SIZE, @center.y - SIZE)
      @owner = game.fetch_player(data['owner'])
      @game = game
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
