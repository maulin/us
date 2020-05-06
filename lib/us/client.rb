require 'net/http'

module Us
  class Client
    HOST = 'localhost'
    PORT = 2009

    def initialize(host: HOST)
      @uri = URI("http://#{host}:#{PORT}")
    end

    def http
      @http ||= Net::HTTP.new(@uri.host, @uri.port)
    end

    def create_game
      http.post('/game', '')
    end

    def update_game
      http.get('/game')
    end

    def join_game(body)
      http.post(
        '/players',
        body.to_json,
        'Content-Type' => 'application/json'
      )
    end
  end
end
