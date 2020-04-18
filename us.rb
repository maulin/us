#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

class GameWindow < Gosu::Window
  GRID_COLOR = Gosu::Color.argb(255, 128, 128, 128)
  WIDTH = 2560
  HEIGHT = 1440
  GRID_DIST = 20

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Uranus's Shame"
    @grid_initialized = false
  end

  def needs_redraw?
    !@grid_initialized
  end

  def draw
    generate_grid
  end

  def generate_grid
    (WIDTH / GRID_DIST).times do |i|
      x = i * GRID_DIST
      draw_line(x, 0, GRID_COLOR, x, HEIGHT, GRID_COLOR)
    end

    (HEIGHT / GRID_DIST).times do |i|
      y = i * GRID_DIST
      draw_line(0, y, GRID_COLOR, WIDTH, y, GRID_COLOR)
    end

    @grid_initialized = true
  end
end

game_window = GameWindow.new
game_window.show
