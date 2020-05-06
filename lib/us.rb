require 'pstore'

require_relative '../lib/us/server'
require_relative '../lib/us/client'
require_relative '../lib/us/server/player'

module Us
  WIDTH = 2560
  HEIGHT = 1440

  @store = PStore.new("us.pstore")
  @client ||= Client.new

  class << self
    attr_reader :current_user, :game
  end

  def self.try_load_user
    @current_user = @store.transaction(true) do
      @store.fetch("user.name", nil)
    end
  end

  def self.create_user(name:)
    @store.transaction do
      @store["user.name"] = name
      @current_user = name
    end
  end

  def self.join_game
    game_data = JSON.parse(@client.join_game)
    @game = Game.new(data: game_data)
  end

  def self.create_game
    Server.start
    sleep 1
    game_data = JSON.parse(@client.create_game.body)
    @game = Game.new(data: game_data)
  end

  def self.update_game
    game_data = JSON.parse(@client.update_game.body)
    @game.update_objects(game_data)
  end
end
