Quad = Struct.new(:nw, :ne, :se, :sw, :center) do
  def contains?(point)
    nw.x < point.x &&
      se.x > point.x &&
      nw.y < point.y &&
      se.y > point.y
  end
end
