#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative './lib/galaxy'

class GameWindow < Gosu::Window
  GRID_COLOR = Gosu::Color.argb(255, 128, 128, 128)
  WIDTH = 2560
  HEIGHT = 1440

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Uranus's Shame"
    @galaxy = Galaxy::Base.new(WIDTH, HEIGHT)
    @grid_initialized = false
  end

  def needs_redraw?
    !@grid_initialized
  end

  def draw
    draw_grid
    draw_stars
  end

  def draw_stars
    @galaxy.stars.each do |s|
      draw_quad(
        s.nw.x, s.nw.y, Gosu::Color::BLUE,
        s.ne.x, s.ne.y, Gosu::Color::BLUE,
        s.sw.x, s.sw.y, Gosu::Color::BLUE,
        s.se.x, s.se.y, Gosu::Color::BLUE
      )
    end
  end

  def draw_grid
    (WIDTH / Galaxy::QUAD_LENGTH).times do |i|
      x = i * Galaxy::QUAD_LENGTH
      draw_line(x, 0, GRID_COLOR, x, HEIGHT, GRID_COLOR)
    end

    (HEIGHT / Galaxy::QUAD_LENGTH).times do |i|
      y = i * Galaxy::QUAD_LENGTH
      draw_line(0, y, GRID_COLOR, WIDTH, y, GRID_COLOR)
    end
    @grid_initialized = true
  end
end

game_window = GameWindow.new
game_window.show
