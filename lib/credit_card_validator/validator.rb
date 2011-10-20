module CreditCardValidator
  CARD_TYPES = {
    :visa => /^4[0-9]{12}(?:[0-9]{3})?$/,
    :master_card => /^5[1-5][0-9]{14}$/,
    :maestro => /(^6759[0-9]{2}([0-9]{10})$)|(^6759[0-9]{2}([0-9]{12})$)|(^6759[0-9]{2}([0-9]{13})$)/,
    :diners_club => /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/,
    :amex => /^3[47][0-9]{13}$/,
    :discover => /^6(?:011|5[0-9]{2})[0-9]{12}$/
  }

  TEST_NUMBERS = {
    :amex => %w{
      378282246310005 371449635398431 378734493671000 },
    :diners_club => %w{
      30569309025904 38520000023237 },
    :discover => %w{
      6011000990139424 6011111111111117 },
    :master_card => %w{
      5555555555554444 5105105105105100 },
    :visa => %w{
      4111111111111111 4012888888881881 4222222222222
      4005519200000004 4009348888881881 4012000033330026
      4012000077777777 4217651111111119 4500600000000061
      4000111111111115 }
  }.values.flatten
  
  class Validator
    class << self
      def valid?(number)
        is_allowed_card_type?(number) and
          verify_luhn(number) and
          card_type(number) and
          (options[:test_numbers_are_valid] ? true : !is_test_number(number))
      end
    
      def options
        @@options ||= {}
      end
    
      def card_type(number)
        CARD_TYPES.keys.each do |t|
          return t.to_s if card_is(t, number)
        end
        nil
      end
    
      def is_allowed_card_type?(number)
        card_type = card_type(number)
        return nil if card_type.nil?
        if options[:allowed_card_types] and options[:allowed_card_types].respond_to?('include?')
          options[:allowed_card_types].include?(card_type.to_sym)
        else
          !card_type.nil?
        end
      end
    
      def is_test_number(number)
        TEST_NUMBERS.include?(strip(number))
      end

      def verify_luhn(number)
        total = strip(number).reverse().split(//).inject([0,0]) do |accum,n|
          n = n.to_i
          accum[0] += (accum[1] % 2 == 1  ? rotate(n * 2)  : n)
          accum[1] += 1
          accum
        end
        
        (total[0] % 10 == 0)
      end
      
      CARD_TYPES.keys.each do |card_type|
        self.class_eval do
          define_method "is_#{card_type.to_s}?" do |number|
            card_is(card_type, number)
          end
        end
      end
      
      protected
      def strip(number)
        number.gsub(/\s/,'')
      end
      
      def rotate(number)
        if number > 9
          number = number % 10 + 1
        end
        number
      end
      
      def card_is(type, number)
        type = type.to_sym
        (CARD_TYPES[type] and strip(number) =~ CARD_TYPES[type])
      end
    end
  end
end
