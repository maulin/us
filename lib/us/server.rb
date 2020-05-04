require 'webrick'
require 'json'

require_relative './server/game'

module Us
  module Server
    class << self
      attr_accessor :game
    end

    def self.start
      return if @pid

      @pid = fork do
        WEBrick::Daemon.start
        server = WEBrick::HTTPServer.new(:Port => 2009)
        server.mount '/games', Games
        server.start
      end
      puts @pid
      Process.detach(@pid)
    end

    class Games < WEBrick::HTTPServlet::AbstractServlet
      def do_POST(req, res)
        Thread.abort_on_exception = true

        if Server.game
          game = Server.game
        else
          game = Server::Game.new
          Server.game = game
          Thread.new { game.run }
        end

        res['Content-Type'] = 'Application/Json'
        res.body = game.to_json
      end

      def do_GET(req, res)
        puts "SERVER GET GAME"
        res['Content-Type'] = 'Application/Json'
        res.body = Server.game.to_json
      end
    end
  end
end
