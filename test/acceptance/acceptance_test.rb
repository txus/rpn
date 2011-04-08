require 'test_helper'

module RPN
  class CalculatorAcceptanceTest < MiniTest::Unit::TestCase

    def setup
      @calculator = Calculator.new
    end

    def test_it_works
      assert_equal 5,    @calculator.solve("2 3 +")
      assert_equal 87,   @calculator.solve("90 3 -")
      assert_equal -4,   @calculator.solve("10 4 3 + 2 * -")
      assert_equal -2,   @calculator.solve("10 4 3 + 2 * - 2 /")
      assert_equal 4037, @calculator.solve("90 34 12 33 55 66 + * - + -")
      assert_equal 8,    @calculator.solve("2 3 ^")
    end
  end
end
