require 'webrick'
require 'json'

require_relative './server/game'

module Us
  module Server
    class << self
      attr_accessor :game, :pid
    end

    def self.start
      pid = fork do
        puts "STARTING SERVER"
        server = WEBrick::HTTPServer.new(:Port => 2009)
        trap('INT') { server.shutdown }
        server.mount '/games', Games
        server.start
      end
      Process.detach(pid)
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
        res['Content-Type'] = 'Application/Json'
        res.body = Server.game.to_json
      end
    end
  end
end
