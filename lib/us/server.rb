require 'webrick'
require 'json'

require_relative './server/game'

module Us
  module Server
    class << self
      attr_accessor :game
    end

    def self.start
      return if @server && @server.status == :Running

      Thread.abort_on_exception = true
      @server = WEBrick::HTTPServer.new(:Port => 2009)
      @server.mount '/games', Games

      Thread.new do
        @server.start
      end
    end

    class Games < WEBrick::HTTPServlet::AbstractServlet
      def do_POST(req, res)
        game = Server::Game.new(state: Us.game_state)
        Server.game = game

        Thread.new { game.run }

        res['Content-Type'] = 'Application/Json'
        res.body = game.to_json
      end

      def do_GET(req, res)
        res['Content-Type'] = 'Application/Json'
        res.body = Server.game.to_json
      end
    end
  end
end
