require_relative 'player'
require_relative 'star'
require_relative 'carrier'
require_relative './menu/hud'
require_relative './menu/star'

module Us
  class Game
    attr_accessor :players
    attr_reader :star_menu

    def initialize(data:)
      @img_star = Gosu::Image.new(File.expand_path('./assets/visible_star.png'))
      @img_carrier = Gosu::Image.new(File.expand_path('./assets/carrier.png'))
      @hud = Menu::Hud.new(self)
      @star_menu = Menu::Star.new
      @ticks = -1

      update_objects(data)
    end

    def draw
      @hud.draw
      @star_menu.draw
      G.draw_with_camera do
        @stars.each do |s|
          s.draw
          @img_star.draw(s.pos.x, s.pos.y, 10)
          s.owner.ring.draw(s.pos.x, s.pos.y, 10)
        end

        @carriers.each do |c|
          c.owner.ring.draw(c.pos.x, c.pos.y, 20)
          @img_carrier.draw(c.pos.x, c.pos.y, 30)
        end
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
        @star_menu.hide
        @hud.handle_click(pos)
      elsif @star_menu.clicked?(pos)
        @star_menu.handle_click(pos)
      else
        @star_menu.hide
        pos = G.untranslate_and_zoom(pos)
        @stars.each { |s| s.handle_click(pos) }
      end
    end
  end
end
