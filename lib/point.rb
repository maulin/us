Point = Struct.new(:x, :y) do
  def to_s
    "X: #{x}, Y: #{y}"
  end
end
