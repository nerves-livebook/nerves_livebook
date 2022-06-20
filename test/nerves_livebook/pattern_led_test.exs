defmodule NervesLivebook.PatternLEDTest do
  use ExUnit.Case, async: true
  alias NervesLivebook.PatternLED

  test "trivial patterns" do
    assert "1 3600000 1 3600000" == PatternLED.on(1)
    assert "255 3600000 255 3600000" == PatternLED.on(255)
    assert "0 3600000 0 3600000" == PatternLED.off()
  end

  describe "blink patterns" do
    test "simple blinking" do
      assert "1 500 1 0 0 500 0 0" == PatternLED.blink(1, 1)
      assert "255 500 255 0 0 500 0 0" == PatternLED.blink(255, 1)
      assert "1 50 1 0 0 50 0 0" == PatternLED.blink(1, 10)
      assert "1 167 1 0 0 166 0 0" == PatternLED.blink(1, 3)
    end

    test "duty cycle" do
      assert "1 250 1 0 0 750 0 0" == PatternLED.blink(1, 1, duty_cycle: 0.25)

      # out of bounds values roughly do what you'd expect
      assert "1 0 1 0 0 1000 0 0" == PatternLED.blink(1, 1, duty_cycle: -100)
      assert "1 1000 1 0 0 0 0 0" == PatternLED.blink(1, 1, duty_cycle: 100)
    end

    test "blinking but off first" do
      assert "0 500 0 0 1 500 1 0" == PatternLED.blink(1, 1, off_first: true)
      assert "0 750 0 0 1 250 1 0" == PatternLED.blink(1, 1, duty_cycle: 0.25, off_first: true)
    end
  end
end
