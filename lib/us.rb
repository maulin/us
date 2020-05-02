require_relative '../lib/us/game_state'
require_relative '../lib/us/server'
require_relative '../lib/us/client'
require_relative '../lib/us/server/player'

module Us
  def self.camera
    @camera ||= Camera.new(GameWindow::WIDTH, GameWindow::HEIGHT)
  end

  def self.create_game
    @game_state.create
  end

  def self.start_server
    Server.start
  end

  def self.client
    @client ||= Client.new
  end

  def self.host
    @host
  end

  def self.game_state
    @game_state ||= GameState.new
  end
end
