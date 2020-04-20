#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative './lib/g'
require_relative './lib/galaxy'
require_relative './lib/game'

class GameWindow < Gosu::Window
  WIDTH = 2560
  HEIGHT = 1440

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Uranus's Shame"
    @game = Game.new(self)
    @grid_initialized = false
  end

  def needs_cursor?
    true
  end

  def needs_redraw?
    @game.state == :unstarted
  end

  def draw
    @game.draw
  end
end

game_window = GameWindow.new
G.window = game_window
game_window.show
