module Menu
  class Star < Base
    def draw
      super
      @items.concat([
        Item::Action.new(
          text: "Buy a carrier to transport ships through hyperspace",
          text_size: :small,
          action_text: "Buy for $25",
          action_text_size: :small,
          callback: -> { @obj.buy_carrier },
          y_pos: 100
        )
      ])
    end
  end
end
