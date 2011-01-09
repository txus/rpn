require 'spec_helper'

module Rpncalc
  describe Parser do
    describe "#initialize" do
      it 'sets the delimiter' do
        parser = Parser.new ' '
        parser.delimiter.should == ' '
      end
      describe "makes the parser raise an InvalidDelimiterError" do
        %w{. + - * / ^ 19 425 0}.each do |invalid_delimiter|
          it "when using #{invalid_delimiter} as a delimiter" do
            expect {
              Parser.new invalid_delimiter
            }.to raise_error(Parser::InvalidDelimiterError)
          end
        end
      end
    end

    describe "#parse" do
      context "with a space delimiter" do
        subject { Parser.new ' ' }

        it 'returns a tokenized array' do
          subject.parse("1 4 5 + -").should == [1, 4, 5, :+, :-]
          subject.parse("1 2 3 4 5 6 7 8 + - * / ^").should == [1, 2, 3, 4, 5, 6, 7, 8, :+, :-, :*, :/, :^]
        end
        describe "edge cases" do
          it 'strips any extra spaces' do
            subject.parse("1    4  5 +  -").should == [1, 4, 5, :+, :-]
          end
        end
      end
      context "with a comma delimiter" do
        subject { Parser.new ',' }

        it 'returns a tokenized array' do
          subject.parse("1,4,5.3,+,-").should == [1, 4, 5.3, :+, :-]
          subject.parse("1,2,3,4,5,6,7,8,+,-,*,/,^").should == [1,2,3,4,5,6,7,8,:+,:-,:*,:/,:^]
        end
        describe "edge cases" do
          it 'strips any extra spaces and delimiter' do
            subject.parse("1,, 4 , 5.3 ,,,+, -").should == [1, 4, 5.3, :+, :-]
          end
        end
      end
      context "with inconsistent or malformed strings" do
        subject { Parser.new ',' }

        it 'raises a MalformedStringError' do
          expect {
            subject.parse "1,4.5,&+,-"
          }.to raise_error(Parser::MalformedStringError, "Offending token: &+")
        end
      end
    end
    
  end
end
