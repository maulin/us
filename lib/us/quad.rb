module Us
  Quad = Struct.new(:p1, :p2, :p3, :p4) do
    def contains?(point)
      p1.x < point.x &&
        p4.x > point.x &&
        p1.y < point.y &&
        p4.y > point.y
    end
  end
end
