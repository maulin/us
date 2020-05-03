require_relative '../lib/us/game_state'
require_relative '../lib/us/server'
require_relative '../lib/us/client'
require_relative '../lib/us/server/player'

module Us
  def self.game_state
    @game_state ||= GameState.new
  end
end
