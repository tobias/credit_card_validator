require File.dirname(__FILE__) + '/test_helper.rb'

class TestCreditCardValidator < Test::Unit::TestCase

  def setup
    @v = CreditCardValidator::Validator
    @v.options.clear
  end
  
  
  def test_recognize_card_type
    assert_equal 'visa', @v.card_type('4111111111111111')
    assert_equal 'master_card', @v.card_type('5555555555554444')
    assert_equal 'diners_club', @v.card_type('30569309025904')
    assert_equal 'amex', @v.card_type('371449635398431')
    assert_equal 'discover', @v.card_type('6011000990139424')

    # Deals with switch and solo.
    assert_equal 'maestro', @v.card_type('633478111298873700')
    assert_equal 'maestro', @v.card_type('6759671431256542')
  end

  def test_detect_specific_types
    assert @v.is_visa?('4111111111111111')
    assert !@v.is_visa?('5555555555554444')
    assert !@v.is_visa?('30569309025904')
    assert !@v.is_visa?('371449635398431')
    assert !@v.is_visa?('6011000990139424')
    assert @v.is_master_card?('5555555555554444')
    assert @v.is_diners_club?('30569309025904')
    assert @v.is_amex?('371449635398431')
    assert @v.is_discover?('6011000990139424')
    assert @v.is_maestro?('6759671431256542')
    assert !@v.is_maestro?('5555555555554444')
    assert !@v.is_maestro?('30569309025904')
  end

  def  test_luhn_verification
    assert @v.verify_luhn('49927398716')
    assert @v.verify_luhn('049927398716')
    assert @v.verify_luhn('0049927398716')
    assert !@v.verify_luhn('49927398715')
    assert !@v.verify_luhn('49927398717')
  end

  def test_ignore_whitespace
    assert_equal '4111111111111111', @v.send('strip', '4111 1111 1111 1111 ')

    assert_equal 'visa', @v.card_type('4111 1111 1111 1111 ')
    assert_equal 'visa', @v.card_type(' 4111 1111 1111 1111 ')
    assert_equal 'visa', @v.card_type("\n4111 1111\t 1111 1111 ")
    assert @v.verify_luhn(' 004 992739 87 16')
    assert @v.is_test_number('601 11111111111 17')
  end

  def test_should_recognize_test_numbers
     %w(
    378282246310005 371449635398431 378734493671000
    30569309025904 38520000023237 6011111111111117
    6011000990139424 5555555555554444 5105105105105100
    4111111111111111 4012888888881881 4222222222222
  ).each do |n|
      assert @v.is_test_number(n)
    end

    assert !@v.is_test_number('1234')
  end
  
  def test_test_number_validity_cases
    assert !@v.valid?('378282246310005')
    @v.options[:test_numbers_are_valid] = true
    assert @v.valid?('378282246310005')
  end

  def test_is_allowed_card_type
    assert @v.is_allowed_card_type?('378282246310005')
    @v.options[:allowed_card_types] = [:visa]
    assert @v.is_allowed_card_type?('4012888888881881')
    assert !@v.is_allowed_card_type?('378282246310005')

  end
    
  def test_card_type_allowance
    @v.options[:test_numbers_are_valid] = true
    assert @v.valid?('378282246310005')
    @v.options[:allowed_card_types] = [:visa]
    assert @v.valid?('4012888888881881')
    assert !@v.valid?('378282246310005')
    
  end
  
end
