#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative './lib/g'
require_relative './lib/game'
require_relative './lib/clock'
require_relative './lib/camera'

class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Uranus's Shame"

    @game = Game.new(self)
    @grid_initialized = false
    @clock = Clock.new
    @camera = Camera.new(WIDTH, HEIGHT)
  end

  def needs_cursor?
    true
  end

  def update
    @clock.tick?
    @camera.move_left if button_down?(Gosu::KbA)
    @camera.move_right if button_down?(Gosu::KbD)
  end

  def draw
    translate(-@camera.nw.x, -@camera.nw.y) do
      # @clock.draw
      @game.draw(@camera)
    end
  end
end

game_window = GameWindow.new
G.window = game_window
game_window.show
