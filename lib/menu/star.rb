module Menu
  class Star < Base
    def draw
      super
      @items.concat([
        Item::Action.new(
          "Buy a carrier to transport ships through hyperspace",
          -> { @obj.buy_carrier }
        )
      ])
    end
  end
end
