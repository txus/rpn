module Rpncalc
  class Stack
    class InsufficientValuesAvailable < StandardError; end;
    class UnsolvableExpressionError < StandardError; end;

    attr_reader :arity, :elements

    def initialize arity
      @arity = arity
      @elements = []
    end

    def solve tokens
      tokens.each do |token|
        if Numeric === token
          push token
          next
        end
        raise InsufficientValuesAvailable
              .new("Cannot apply #{token} to less than #{arity} values!") if size < arity
        result = pop(arity).inject do |acc, e|
          acc.send(token, e)
        end
        push result
      end
      raise UnsolvableExpressionError.new("The final stack contained more than one value: #{elements.inspect}") if size > 1
      elements.first
    end

    def push token
      elements.push token
    end

    def pop amount
      elements.pop amount
    end

    def size
      elements.size
    end

  end
end
