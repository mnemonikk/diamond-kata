require "minitest/autorun"

class TestCanvas < Minitest::Test
  def test_draw
    canvas = Canvas.new(3)
    canvas[0, 0] = "X"
    canvas[1, 1] = "Y"
    canvas[0, 2] = "Z"
    canvas[2, 0] = "A"
    assert_equal <<-EOS, canvas.to_s
X A
 Y 
Z  
    EOS
  end
end

Canvas = Struct.new(:size) do
  def to_s
    rows.map { |row| row + "\n" }.join
  end

  def []=(x, y, value)
    rows.fetch(y)[x] = value
  end

  private

  def rows
    @rows ||= Array.new(size) { " " * size }
  end
end
