#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative '../lib/us'
require_relative '../lib/us/g'
require_relative '../lib/us/game_window'

game_window = Us::GameWindow.new
G.window = game_window
game_window.show
