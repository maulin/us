module Us
  class Carrier < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/carrier.png'))

    attr_reader :start, :waypointing, :waypoints

    def initialize(data:, game:)
      super
      set_waypoints(data)
      @ships = data['ships']
      @dest = game.fetch_star(data['dest'])
      @angle = get_angle
      @bottom_middle = Point.new(@center.x, @center.y + SIZE + 5)
    end

    def get_angle
      heading = @dest || @waypoint_stars.first
      if heading
        Vector.new(center, heading.center).rotation_angle
      else
        0
      end
    end

    def set_waypoints(data)
      @waypoints = []
      @waypoint_stars = []
      data['waypoints'].each do |w|
        star = game.fetch_star(w.first)
        @waypoints << [star, w.last]
        @waypoint_stars << star
      end
    end

    def reset_waypoints
      @waypoints = []
      @waypoint_stars = []
      save_waypoints
    end

    def save_waypoints
      Us.update_game(params: {
        order: {
          order: 'waypoints',
          id: id,
          waypoints: @waypoints.map { |w| [w.first.id, w.last] }
        }
      })
    end

    def draw
      owner.ring.draw(pos.x, pos.y, 20)
      G.draw_text(text: @ships, pos: @bottom_middle, z: 10, size: :tiny)
      Gosu.rotate(@angle, center.x, center.y) do
        SPRITE.draw(pos.x, pos.y, 30)
      end

      draw_waypoints
      draw_hyperspace
    end

    def current_waypoint
      @waypoint_stars.last || @dest || game.fetch_star_at(center)
    end

    def draw_waypoints
      if @waypointing
        current_waypoint.show_waypoint_locations
      end

      @waypoint_stars.each_index do |i|
        s, d = @waypoint_stars[i..i + 1]
        G.draw_line(p1: s.center, p2: d.center, z: 10, color: owner.color) if s && d
      end

      if !@dest && !@waypoints.empty?
        G.draw_line(p1: center, p2: @waypoint_stars.first.center, z: 10, color: owner.color)
      elsif @dest && !@waypoints.empty?
        G.draw_line(p1: @dest.center, p2: @waypoint_stars.first.center, z: 10, color: owner.color)
      end
    end

    def draw_hyperspace
      return unless @dest

      G.draw_line(p1: center, p2: @dest.center, z: 10, color: :hyperspace)
    end

    def start_waypointing
      @waypointing = true
    end

    def stop_waypointing
      @waypointing = false
      current_waypoint.hide_waypoint_locations
    end

    def try_set_new_waypoint(pos)
      pos = G.untranslate_and_zoom(pos)
      star = game.fetch_star_at(pos)
      if current_waypoint.waypoint_locations.include?(star)
        current_waypoint.hide_waypoint_locations
        @waypoints << [star, "+"]
        @waypoint_stars << star
      end
    end
  end
end
