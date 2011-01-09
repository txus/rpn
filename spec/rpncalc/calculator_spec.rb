require 'spec_helper'

module Rpncalc
  describe Calculator do
    describe "#initialize" do
      context "with no arguments" do
        it 'sets default arity' do
          Stack.should_receive(:new).with(2)
          Calculator.new
        end
        it 'sets default delimiter' do
          Parser.should_receive(:new).with(' ')
          Calculator.new
        end
      end
      it 'accepts a custom arity' do
        Stack.should_receive(:new).with(3)
        Calculator.new :arity => 3
      end
      it 'accepts a custom delimiter' do
        Parser.should_receive(:new).with(',')
        Calculator.new :delimiter => ','
      end
      it 'creates an accessible stack' do
        calculator = Calculator.new
        calculator.stack.should be_kind_of(Stack)
      end
      it 'creates an accessible parser' do
        calculator = Calculator.new
        calculator.parser.should be_kind_of(Parser)
      end
    end

    describe "#solve" do
      it 'passes the string to the parser' do
        subject.stack.stub(:solve)
        subject.parser.should_receive(:parse).with "3 4 +"
        subject.solve "3 4 +"
      end
      it 'delegates solving to the stack' do
        subject.parser.stub(:parse).and_return ["3", "4", "+"]
        subject.stack.should_receive(:solve).with ["3", "4", "+"]
        subject.solve "3 4 +"
      end
    end
  end
end
