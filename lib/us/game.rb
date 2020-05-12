require_relative 'player'
require_relative 'game_object'
require_relative 'star'
require_relative 'carrier'
require_relative './menu/hud'
require_relative './menu/star'
require_relative './menu/objects'

module Us
  class Game
    attr_accessor :players

    def initialize(data:)
      @img_star = Gosu::Image.new(File.expand_path('./assets/visible_star.png'))
      @hud = Menu::Hud.new(self)
      @menus = {
        star: Menu::Star.new,
        objects: Menu::Objects.new
      }
      @ticks = -1

      update_objects(data)
    end

    def draw
      @hud.draw
      visible_menu.draw if visible_menu
      G.draw_with_camera do
        @stars.each { |s| s.draw }
        @carriers.each { |c| c.draw }
      end
    end

    def update_objects(data)
      @state = data['state'].to_sym

      @ticks = data['clock']['ticks']
      @tick_start_time = data['clock']['tick_start_time']

      @players = data['players'].map { |p| Player.new(data: p) }
      @stars = data['stars'].map { |s| Star.new(data: s, players: @players) }
      @carriers = data['carriers'].map { |c| Carrier.new(data: c, players: @players) }

      @last_update = Time.now.utc.to_i
    end

    def fetch_player(id:)
      @players.find { |p| p.id == id }
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

    def handle_click(pos)
      if @hud.clicked?(pos)
        @hud.handle_click(pos)
      elsif visible_menu
        visible_menu.handle_click(pos)
      else
        visible_menu.hide if visible_menu
        pos = G.untranslate_and_zoom(pos)
        objects = game_objects_at(pos)
        show_menu_for(objects)
      end
    end

    def visible_menu
      menu = @menus.find { |k, v| v.visible? }
      menu.last if menu
    end

    def show_menu_for(objects)
      if objects.count > 1
        @menus[:objects].show(objects)
      else
        object = objects.first
        menu_type = object.menu_type
        @menus[menu_type].show(object)
      end
    end

    def game_objects_at(pos)
      objects = []
      @stars.each do |s|
        objects << s if s.clicked?(pos)
      end
      @carriers.each do |c|
        objects << s if c.clicked?(pos)
      end
      objects
    end
  end
end
