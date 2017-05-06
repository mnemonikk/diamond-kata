require "minitest/autorun"
require_relative "canvas"
require_relative "translation"
require_relative "reflection"

class TestDiamond < Minitest::Test
  def test_end_to_end
    assert_equal <<-EOS, Diamond.new("A").to_s
A
EOS

    assert_equal <<-EOS, Diamond.new("B").to_s
 A 
B B
 A 
    EOS

    assert_equal <<-EOS, Diamond.new("C").to_s
  A  
 B B 
C   C
 B B 
  A  
    EOS
  end
end

Diamond = Struct.new(:last) do
  FIRST = "A"

  def to_s
    draw!
    canvas.to_s
  end

  private

  def draw!
    FIRST.upto(last).zip(
      0.upto(radius),
      radius.downto(0)
    ).each do |letter, x, y|
      canvas[x, y] = letter
    end
  end

  def canvas
    @canvas ||=
      Reflection.new(
        Reflection.new(
          Translation.new(
            Canvas.new(width),
            radius, radius
          ),
          1, -1
        ),
        -1, 1
      )
  end

  def radius
    @radius ||= last.ord - FIRST.ord
  end

  def width
    radius * 2 + 1
  end
end
