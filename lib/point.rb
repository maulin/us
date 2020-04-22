Point = Struct.new(:x, :y) do
  def to_s
    "X: #{x.round(2)}, Y: #{y.round(2)}"
  end
end
