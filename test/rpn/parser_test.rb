require 'test_helper'

module RPN
  class ParserTest < MiniTest::Unit::TestCase

    def test_initialize_sets_the_delimiter
      assert_equal ' ', Parser.new(' ').delimiter
    end

    def test_invalid_delimiters
      %w{. + - * / ^ 19 425 0}.each do |invalid_delimiter|
        assert_raises Parser::InvalidDelimiterError do
          Parser.new invalid_delimiter
        end
      end
    end

    def test_parser_with_a_space_delimiter_returns_a_tokenized_array
      parser = Parser.new(' ')
      assert_equal [1, 4, 5, :+, :-],
        parser.parse("1 4 5 + -")
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, :+, :-, :*, :/, :**],
        parser.parse("1 2 3 4 5 6 7 8 + - * / ^")
      assert_equal [1, 4, 5, :+, :-],
        parser.parse("1     4  5 +    -")
    end

    def test_parser_with_a_comma_delimiter_returns_a_tokenized_array
      parser = Parser.new(',')
      assert_equal [1, 4, 5.3, :+, :-],
        parser.parse("1,4,5.3,+,-")
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, :+, :-, :*, :/, :**],
        parser.parse("1,2,3,4,5,6,7,8,+,-,*,/,^")
      assert_equal [1, 4, 5, :+, :-],
        parser.parse("1,,,     4 ,, 5, +   ,-")
    end
    
    def test_parser_with_inconsistent_or_malformed_strings
      assert_raises Parser::MalformedStringError do
        Parser.new(' ').parse("1 4.5 &+ -")
      end
    end

    def test_parser_with_element_zero
      parser = Parser.new(' ')
      assert_equal [100, 0.5, :-], parser.parse("100 0.5 -")
      assert_equal [100, 0.009, :-], parser.parse("100 0.009 -")
    end

  end
end
