module Rpncalc
  class Parser
    class MalformedStringError < StandardError; end;
    class InvalidDelimiterError < StandardError; end;
    
    TOKENS = %w{. + - * / ^ ln log10}

    attr_reader :delimiter

    def initialize delimiter
      @delimiter = validate(delimiter)
    end

    def parse string
      string.gsub(/#{delimiter}+/, delimiter)
            .split(delimiter).map(&:strip).map do |element|
        if element.to_i.zero? && element != '0'
          if TOKENS.include?(element)
            element.to_sym
          else
            raise MalformedStringError.new("Offending token: #{element}")
          end
        else
          element =~ /\./ ? element.to_f
                          : element.to_i
        end
      end
    end

    private

    def validate delimiter
      if TOKENS.include?(delimiter.strip) ||
          delimiter =~ /[0-9]+/
        raise InvalidDelimiterError.new
      end
      delimiter
    end
  end
end
