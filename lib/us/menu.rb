require_relative './menu/base'
require_relative './menu/star'
require_relative './menu/items/action'

module Us
  module Menu
    HEIGHT = 1440
    WIDTH = 500

    def self.create_for(object, kaller)
      klass = const_get(object.class.name)
      klass.new(object, kaller)
    end
  end
end
