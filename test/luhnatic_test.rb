require 'test_helper'

class LuhnaticTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Luhnatic::VERSION
  end

  def test_it_validates_the_check_sum_on_7_digit_expression_that_matches_luhn_N_mod_algorithm
    expression = 'ErGLfG'
    assert Luhnatic::Luhn.valid?(expression)
  end

  def test_it_invalidates_when_the_check_sum_does_not_match
    expression = 'vY9i2c'
    refute Luhnatic::Luhn.valid?(expression)
  end

  def test_it_doubles_mods_and_adds_1_greater_than_5
    assert Luhnatic::Luhn.double_and_evaluate(5), 5
  end

  def test_it_doubles_mods_and_adds_1_less_than_6
    assert Luhnatic::Luhn.double_and_evaluate(3), 1
  end
end
