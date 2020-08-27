#!/home/maulin/.rbenv/shims/ruby

require 'rubygems'
require 'bundler/setup'
require 'gosu'

require_relative '../lib/us'
require_relative '../lib/us/g'
require_relative '../lib/us/game_window'
require_relative '../lib/us/camera'

Process.setproctitle("us-game")
Us.try_load_user
game_window = Us::GameWindow.new
G.window = game_window
G.camera = Us::Camera.new
game_window.show
