module RPN
  class Calculator
    attr_reader :parser, :stack
    def initialize options = {}
      arity, delimiter = options[:arity] || 2,
                         options[:delimiter] || ' '
      @stack = Stack.new(arity)
      @parser = Parser.new(delimiter)
    end
    def solve string
      stack.solve parser.parse(string)
    end
  end
end
