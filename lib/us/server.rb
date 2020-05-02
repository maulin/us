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
      trap('INT') { @server.shutdown }
      @server.mount '/games', Games

      Thread.new do
        @server.start
      end
    end

    class Games < WEBrick::HTTPServlet::AbstractServlet
      def do_POST(req, res)
        game = Server::Game.new
        Server.game = game

        res['Content-Type'] = 'Application/Json'
        res.body = game.to_json
      end
    end
  end
end
