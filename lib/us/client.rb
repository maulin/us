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
      http.post('/games', "")
    end
  end
end
