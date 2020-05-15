require_relative 'player'
require_relative 'game_object'
require_relative 'star'
require_relative 'carrier'
require_relative './menu/hud'
require_relative './menu/objects'

module Us
  class Game
    MENUS = {
      star: Menu::Star.new,
      carrier: Menu::Carrier.new,
      objects: Menu::Objects.new
    }
    attr_accessor :players

    def initialize(data:)
      @img_star = Gosu::Image.new(File.expand_path('./assets/visible_star.png'))
      @hud = Menu::Hud.new(self)
      @ticks = -1

      update_objects(data)
    end

    def draw
      @hud.draw
      @visible_menu.draw if @visible_menu
      G.draw_with_camera do
        @stars.each { |s| s.draw }
        @carriers.each { |c| c.draw }
      end
    end

    def update_objects(data)
      @state = data['state'].to_sym

      @ticks = data['clock']['ticks']
      @tick_start_time = data['clock']['tick_start_time']

      @players = data['players'].map { |p| Player.new(p) }
      @stars = data['stars'].map { |s| Star.new(data: s, game: self) }
      @carriers = data['carriers'].map { |c| Carrier.new(data: c, game: self) }

      @last_update = Time.now.utc.to_i
    end

    def fetch_player(id)
      @players.find { |p| p.id == id }
    end

    def fetch_star(id)
      @stars.find { |s| s.id == id }
    end

    def clock
      if @state == :started
        time_since_last_tick = Time.now.utc.to_i - @tick_start_time
        "#{Gosu.fps} Production: #{Us::Server::Clock::TICK_INTERVAL - time_since_last_tick}s"
      else
        "#{Gosu.fps} Unstarted"
      end
    end

    def update
      return unless @state == :started
      current_time = Time.now.utc.to_i
      if current_time - @tick_start_time > Us::Server::Clock::TICK_INTERVAL && current_time - @last_update > 1
        Us.update_game
      end
    end

    def close_menu
      @visible_menu = nil
    end

    def show_menu_for(object)
      @visible_menu = MENUS[object.menu_type]
      @visible_menu.show(object)
    end

    def handle_click(pos)
      puts "game handle click"
      if @hud.clicked?(pos)
        puts "hud clicked"
        @hud.handle_click(pos)
      elsif @visible_menu
        puts "visible menu handle click"
        @visible_menu.handle_click(pos)
      else
        puts "finding objects"
        pos = G.untranslate_and_zoom(pos)
        objects = game_objects_at(pos)
        puts objects
        return if objects.empty?

        if objects.count > 1
          puts "showing objects menu"
          @visible_menu = MENUS[:objects]
          @visible_menu.show(objects)
        else
          object = objects.first
          puts "showing single object menu"
          @visible_menu = MENUS[object.menu_type]
          @visible_menu.show(object)
        end
      end
    end

    def game_objects_at(pos)
      objects = []
      @stars.each do |s|
        objects << s if s.clicked?(pos)
      end
      @carriers.each do |c|
        objects << c if c.clicked?(pos)
      end
      objects
    end

    def jump_locations_from(star)
      @stars.select do |s|
        magnitude = Vector.new(s.pos, star.pos).magnitude
        magnitude <= Us.current_player.hyperspace_range
      end
    end
  end
end
