require 'luhnatic/version'
require 'base62'

module Luhnatic
  class Luhn
    extend Base62

    DoubleKnower = Struct.new(:value, :dbl?) do
    end

    class << self
      def valid?(expression)
        return false if expression.empty? || expression.size < 6

        calculate_mod(expression) == 0
      end

      def calculate_mod(expression)
        reversed_exp = expression.reverse
        chars = reversed_exp.scan(/\w/)
        evaluations = []
        sum = 0

        chars.each_with_index do |num, idx|
          evaluations << DoubleKnower.new(num, idx.odd?)
        end

        evaluations.each do |ev|
          num_value = base62(ev.value).to_i
          sum += (ev.dbl? ? double_value(num_value) : num_value)
        end

        sum % 62
      end

      def double_value(value)
        2 * value
      end

      def double_and_evaluate(value)
        2 * value > 5 ? ((2 * value) % 6 + 1) : 2 * value
      end

      private

      def base62(ch)
        Base62.decode(ch.to_s)
      end
    end
  end
end
