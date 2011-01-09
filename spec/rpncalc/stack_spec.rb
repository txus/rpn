require 'spec_helper'

module Rpncalc
  describe Stack do
    subject { Stack.new 2 }

    describe "#initialize" do
      it 'sets the delimiter' do
        stack = Stack.new 3
        stack.arity.should == 3
      end
    end

    describe "#solve", "iterates the tokens" do
      context 'when the token is a value' do
        it 'pushes it to the stack' do
          subject.should_receive(:push).with 3
          subject.solve [3]
        end
      end
      context 'when the token is an operator' do
        context 'if the size of the stack is below the arity' do
          it 'raises an error' do
            subject.stub(:size).and_return 1
            expect {
              subject.solve [:+]
            }.to raise_error(Stack::InsufficientValuesAvailable)
          end
        end
        context 'otherwise' do
          it 'pops n elements from the stack and pushes the result' do
            subject.stub(:size).and_return 3, 1
            elements = [1,2]
            subject.should_receive(:pop).with(subject.arity).and_return elements
            subject.should_receive(:push).with(3)

            subject.solve [:+]
          end
        end
      end
      context 'when at the end there is more than one result' do
        it 'raises an error' do
          subject.stub(:size).and_return 2
          expect {
            subject.solve [:+]
          }.to raise_error(Stack::UnsolvableExpressionError)
        end
      end
      context 'when everything is fine' do
        it 'returns the result' do
          subject.stub(:size).and_return 3, 1
          elements = [1,2]
          subject.stub(:pop).with(subject.arity).and_return elements

          subject.solve([:+]).should == 3
        end
      end
    end

    describe "#push" do
      it 'pushes a token to the elements collection' do
        subject.elements.should_receive(:push).with 3
        subject.push 3
      end
    end
    describe "#pop" do
      it 'pushes a token to the elements collection' do
        subject.elements.should_receive(:pop).with 2
        subject.pop 2
      end
    end
    describe "#size" do
      it 'pushes a token to the elements collection' do
        subject.elements.should_receive(:size)
        subject.size
      end
    end

  end
end
