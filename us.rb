#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative './lib/g'
require_relative './lib/game'
require_relative './lib/clock'
require_relative './lib/camera'

class GameWindow < Gosu::Window
  WIDTH = 1024
  HEIGHT = 768

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

  def button_down(id)
    case id
    when Gosu::MsWheelDown
      @camera.zoom_in
    when Gosu::MsWheelUp
      @camera.zoom_out
    when Gosu::KbSpace
      @camera.reset
    end
  end

  def update
    @clock.tick?
    @camera.move_left if button_down?(Gosu::KbA)
    @camera.move_right if button_down?(Gosu::KbD)
    @camera.move_up if button_down?(Gosu::KbW)
    @camera.move_down if button_down?(Gosu::KbS)
  end

  def draw
    @clock.draw
    translate(-@camera.pos.x, -@camera.pos.y) do
      scale(@camera.zoom, @camera.zoom, @camera.pos.x, @camera.pos.y) do
        @game.draw(@camera)
      end
    end
  end
end

game_window = GameWindow.new
G.window = game_window
game_window.show
