require "minitest/autorun"

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

  def test_letters
    assert_equal "A".chars, Diamond.new("A").letters
    assert_equal "ABA".chars, Diamond.new("B").letters
    assert_equal "ABCBA".chars, Diamond.new("C").letters
  end

  def test_line_for
    assert_equal "A\n", Diamond.new("A").line_for("A")
    assert_equal " A \n", Diamond.new("B").line_for("A")
    assert_equal "B B\n", Diamond.new("B").line_for("B")
    assert_equal " B B \n", Diamond.new("C").line_for("B")
    assert_equal "C   C\n", Diamond.new("C").line_for("C")
  end
end

Diamond = Struct.new(:last) do
  FIRST = "A"

  def to_s
    lines.join
  end

  def lines
    letters.map(&method(:line_for))
  end

  def letters
    (FIRST...last).to_a + (FIRST..last).to_a.reverse
  end

  def line_for(letter)
    outer_padding = " " * (width - (letter.ord - FIRST.ord))
    if letter == FIRST
      outer_padding + letter + outer_padding
    else
      inner_padding = " " * ((letter.ord - FIRST.ord) * 2 - 1)
      outer_padding + letter + inner_padding + letter + outer_padding
    end + "\n"
  end

  private

  def width
    last.ord - FIRST.ord
  end
end
