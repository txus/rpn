require 'spec_helper'

module RPN
  describe Calculator do

    it 'works like a charm' do
      subject.solve("2 3 +").should == 5
      subject.solve("90 3 -").should == 87
      subject.solve("10 4 3 + 2 * -").should == -4
      subject.solve("10 4 3 + 2 * - 2 /").should == -2
      subject.solve("90 34 12 33 55 66 + * - + -").should == 4037
      subject.solve("2 3 ^").should == 8
    end

  end

end
