require "minitest/autorun"
require_relative "canvas"
require_relative "translation"

class TestReflection < Minitest::Test
  def test_reflection
    canvas =
      Reflection.new(
        Translation.new(
          Canvas.new(3),
          1, 1
        ),
        -1, 1
      )
    canvas[0, 0] = "A"
    canvas[1, 1] = "B"
    assert_equal <<-EOS, canvas.to_s
   
 A 
B B
    EOS
  end
end

class Reflection  < SimpleDelegator
  def initialize(canvas, factor_x, factor_y)
    super(canvas)
    @factor_x = factor_x
    @factor_y = factor_y
  end

  def []=(x, y, value)
    __getobj__[x, y] = value
    __getobj__[x * factor_x, y * factor_y] = value
  end

  private

  attr_reader :factor_x, :factor_y
end
