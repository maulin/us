require 'pstore'

require_relative './menu'
require_relative './menu/game'
require_relative './menu/user'
require_relative './menu/hud'
require_relative './game'

module Us
  class GameState
    attr_reader :state

    def initialize
      @store = PStore.new("us.pstore")
      @client ||= Client.new

      if current_user
        setup_game
      else
        setup_user
      end
    end

    def setup_user
      @state_obj = Menu::User.new(state: self)
      @state = :create_user
    end

    def setup_game
      Server.start
      @state_obj = Menu::Game.new(state: self)
      @state = :unstarted
    end

    def create_game
      game_data = JSON.parse(@client.create_game.body)
      @state_obj = Game.new(game_data, self)
      @state = :created
    end

    def update_game
      game_data = JSON.parse(@client.update_game.body)
      @state_obj.update_objects(game_data)
    end

    def current_user
      @store.transaction(true) { @store.fetch("user.name", nil) }
    end

    def create_user(name:)
      @store.transaction do 
        @store["user.name"] = name
      end
    end

    def handle_click(pos)
      @state_obj.handle_click(pos)
    end
    
    def handle_return
      return unless @state == :create_user
      @state_obj.handle_return
    end

    def draw
      @state_obj.draw
    end

    def update
      return unless @state_obj.is_a? Game

      @state_obj.update
    end
  end
end
