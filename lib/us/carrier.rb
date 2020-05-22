module Us
  class Carrier < GameObject
    SPRITE = Gosu::Image.new(File.expand_path('./assets/carrier.png'))

    attr_reader :start, :waypointing, :waypoints

    def initialize(data:, game:)
      super
      set_waypoints(data)
      @dest = game.fetch_star(data['dest'])
      @angle = get_angle
    end

    def get_angle
      heading = @dest || @waypoints.first
      if heading
        Vector.new(center, heading.center).rotation_angle
      else
        0
      end
    end

    def set_waypoints(data)
      @waypoints = []
      data['waypoints'].each do |id|
        @waypoints << game.fetch_star(id)
      end
    end

    def reset_waypoints
      @waypoints = []
      save_waypoints
    end

    def save_waypoints
      Us.update_game(params: {
        order: {
          order: 'waypoints',
          id: id,
          waypoints: @waypoints.map(&:id)
        }
      })
    end

    def draw
      owner.ring.draw(pos.x, pos.y, 20)
      Gosu.rotate(@angle, center.x, center.y) do
        SPRITE.draw(pos.x, pos.y, 30)
      end

      draw_waypoints
      draw_hyperspace
    end

    def current_waypoint
      @waypoints.last || @dest || game.fetch_star_at(center)
    end

    def draw_waypoints
      if @waypointing
        current_waypoint.show_waypoint_locations
      end

      @waypoints.each_index do |i|
        s, d = @waypoints[i..i + 1]
        G.draw_line(p1: s.center, p2: d.center, z: 10, color: owner.color) if s && d
      end

      if !@dest && !@waypoints.empty?
        G.draw_line(p1: center, p2: @waypoints.first.center, z: 10, color: owner.color)
      elsif @dest && !@waypoints.empty?
        G.draw_line(p1: @dest.center, p2: @waypoints.first.center, z: 10, color: owner.color)
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
        @waypoints << star
      end
    end

    def waypoints_text
      @waypoints.map(&:name).join(' -> ')
    end
  end
end
