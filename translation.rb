require "minitest/autorun"
require_relative "canvas"

class TestTranslation < Minitest::Test
  def test_translation
    canvas = Translation.new(Canvas.new(3), 1, 1)
    canvas[0, 0] = "A"
    assert_equal <<-EOS, canvas.to_s
   
 A 
   
    EOS
  end
end

class Translation < SimpleDelegator
  def initialize(canvas, offset_x, offset_y)
    super(canvas)
    @offset_x = offset_x
    @offset_y = offset_y
  end

  def []=(x, y, value)
    __getobj__[x + offset_x, y + offset_y] = value
  end

  private

  attr_reader :offset_x, :offset_y
end
