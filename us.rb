#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative './lib/g'
require_relative './lib/game'
require_relative './lib/clock'

class GameWindow < Gosu::Window
  WIDTH = 2560
  HEIGHT = 1440

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Uranus's Shame"

    @game = Game.new(self)
    @grid_initialized = false
    @clock = Clock.new
  end

  def needs_cursor?
    true
  end

  def button_up(id)
    case id
    when Gosu::MS_LEFT
    end
  end

  def update
    if @clock.tick?
      @game.move_objects
    end
  end

  def draw
    @clock.draw
    @game.draw
  end
end

game_window = GameWindow.new
G.window = game_window
game_window.show
