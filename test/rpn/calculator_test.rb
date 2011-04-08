require 'test_helper'

module RPN
  class CalculatorTest < MiniTest::Unit::TestCase

    def test_initialize_sets_default_arity
      Stack.expects(:new).with(2)
      Calculator.new
    end

    def test_initialize_sets_default_delimiter
      Parser.expects(:new).with(' ')
      Calculator.new
    end

    def test_accepts_custom_arity
      Stack.expects(:new).with(3)
      Calculator.new :arity => 3
    end

    def test_accepts_custom_delimiter
      Parser.expects(:new).with(',')
      Calculator.new :delimiter => ','
    end

    def test_creates_an_accessible_stack
      assert_kind_of Stack, Calculator.new.stack
    end

    def test_creates_an_accessible_stack
      assert_kind_of Parser, Calculator.new.parser
    end

    def test_solve_passes_the_string_onto_the_parser
      calculator = Calculator.new
      calculator.stack.stubs(:solve)
      calculator.parser.expects(:parse).with "3 4 +"

      calculator.solve "3 4 +"
    end

    def test_solve_elegates_solving_to_the_stack
      calculator = Calculator.new
      calculator.parser.stubs(:parse).returns ["3", "4", "+"]
      calculator.stack.expects(:solve).with ["3", "4", "+"]

      calculator.solve "3 4 +"
    end

  end
end
