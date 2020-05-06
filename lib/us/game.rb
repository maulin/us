require_relative 'player'
require_relative './menu/hud'

module Us
  class Game
    attr_accessor :players

    def initialize(data:)
      @ring = Gosu::Image.new(File.expand_path('./assets/orange.png'))
      @star = Gosu::Image.new(File.expand_path('./assets/visible_star.png'))
      @hud = Menu::Hud.new(self)
      @ticks = -1

      update_objects(data)
    end

    def draw
      @hud.draw
      @stars.each do |s|
        @star.draw(s['x'], s['y'], 10)
        owner = players.find { |p| p.id == s['o'] }
        owner.ring.draw(s['x'], s['y'], 10)
      end
    end

    def update_objects(data)
      return if data['clock']['ticks'] <= @ticks

      @state = data['state'].to_sym
      @stars = data['stars']
      @ticks = data['clock']['ticks']
      @tick_start_time = data['clock']['tick_start_time']

      @players = data['players'].map { |p| Player.new(id: p['id'], name: p['name'], color: p['color']) }
      @last_update = Time.now.utc.to_i
    end

    def clock
      if @state == :started
        time_since_last_tick = Time.now.utc.to_i - @tick_start_time
        "#{Gosu.fps} Production: #{Us::Server::Clock::PROD_INTERVAL - time_since_last_tick}s"
      else
        "#{Gosu.fps} Unstarted"
      end
    end

    def update
      return unless @state == :started

      current_time = Time.now.utc.to_i
      if current_time - @tick_start_time > Us::Server::Clock::PROD_INTERVAL && current_time - @last_update > 1
        Us.update_game
      end
    end

    def handle_click(pos)
      @hud.handle_click(pos)
    end
  end
end
