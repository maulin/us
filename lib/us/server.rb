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
        Process.setproctitle("us-game-server")
        puts "SERVER: Starting server process"

        log_file = File.new('server.log', 'w+')
        log = WEBrick::Log.new(log_file)

        # WEBrick::Daemon.start
        server = WEBrick::HTTPServer.new(Port: 2009, Logger: log)
        trap('TERM') do
          server.shutdown
          exit 0
        end
        server.mount '/game', GameServelet
        server.mount '/game_orders', GameOrders
        server.mount '/players', PlayersServelet
        server.start
      end

      puts pid
      Process.detach(pid)
    end

    class GameServelet < WEBrick::HTTPServlet::AbstractServlet
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
    end

    class GameOrders < WEBrick::HTTPServlet::AbstractServlet
      def do_POST(req, res)
        params = JSON.parse(req.body)
        res['Content-Type'] = 'Application/Json'
        res.body = Server.game.fetch_for(player_id: params['player_id'])
      end
    end

    class PlayersServelet < WEBrick::HTTPServlet::AbstractServlet
      def do_POST(req, res)
        game = Server.game
        return unless game

        params = JSON.parse(req.body)
        res['Content-Type'] = 'Application/Json'

        player = game.player?(id: params['id'])
        if !player
          player = game.add_player(name: params['name'])
        end

        res.body = player.basic_resp.to_json
      end
    end
  end
end
