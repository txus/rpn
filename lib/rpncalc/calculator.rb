module Rpncalc
  class Calculator
    attr_reader :parser, :stack
    def initialize options = {}
      arity, separator = options[:arity] || 2,
                         options[:separator] || ' '
      @stack = Stack.new(arity)
      @parser = Parser.new(separator)
    end
    def solve string
      stack.handle parser.parse(string)
    end
  end
end
