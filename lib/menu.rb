require_relative './menu/base'
require_relative './menu/star'

module Menu
  HEIGHT = 1440
  WIDTH = 400

  def self.create_for(object, kaller)
    klass = const_get(object.class.name)
    klass.new(object, kaller)
  end
end
