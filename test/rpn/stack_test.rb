require 'test_helper'

module RPN
  class StackTest < MiniTest::Unit::TestCase
    def setup
      @stack = Stack.new(2)
    end

    def test_initialize_sets_the_arity
      assert_equal 3, Stack.new(3).arity
    end

    def test_solve_pushes_a_value_token
      @stack.expects(:push).with 3
      @stack.solve [3]  
    end

    def test_solve_with_operator_token_raises_if_the_size_is_below_arity
      @stack.stubs(:size).returns 1
      assert_raises Stack::InsufficientValuesAvailable do
        @stack.solve [:+]
      end
    end

    def test_solve_with_operator_token_pops_n_elements_and_pushes_result
      @stack.stubs(:size).returns 3, 1
      elements = [1, 2]

      @stack.expects(:pop).with(2).returns(elements)
      @stack.expects(:push).with(3)

      @stack.solve [:+]
    end

    def test_solve_raises_error_if_more_than_one_result
      @stack.stubs(:size).returns(2)
      assert_raises Stack::UnsolvableExpressionError do
        @stack.solve [:+]
      end
    end

    def test_solve_returns_the_result_if_everything_is_ok
      @stack.stubs(:size).returns 3, 1
      elements = [1, 2]
      @stack.stubs(:pop).with(2).returns elements

      assert_equal 3, @stack.solve([:+])
    end

    def test_solve_clears_the_stack_before_each_call
      @stack.solve [3]
      @stack.solve [4]
      assert_equal [4], @stack.elements
    end

    def test_push_delegates_to_elements
      @stack.elements.expects(:push).with 3
      @stack.push 3
    end

    def test_pop_delegates_to_elements
      @stack.elements.expects(:pop).with 2
      @stack.pop 2
    end

    def test_size_delegates_to_elements
      @stack.elements.expects(:size)
      @stack.size
    end

    def test_clear_clears_the_stack
      @stack.elements.expects(:clear)
      @stack.clear
    end
  end
end
