require 'test_helper'

class StatisticsTest < ActiveSupport::TestCase
  def setup
    @user = "Здесь должен быть наш тестовый. По-хорошему все значения в тестах можно будет подогнать под тестовго пользователя"
  end

  test "get_the_longest_black_stripe returns the correct length" do
    assert @user.get_the_longest_black_stripe == 5
  end

  test "get_the_longest_white_stripe returns the correct length" do
    assert @user.get_the_white_black_stripe == 3  # 😢
  end

  test "get_count_good_days returns the correct value" do
    assert @user.get_count_good_days == 6
  end

  test "get_count_bad_days returns the correct value" do
    assert @user.get_count_good_days == 11  # 😭
  end

  test "get_count_bad_days_last_full_month returns the correct value" do
    assert @user.get_count_good_days_last_full_month == 6
  end

  test "get_count_good_days_last_full_month returns the correct value" do
    assert @user.get_count_good_days_last_full_month == 3
  end

  test "get_the_longest_black_stripe_last_full_month returns the correct length" do
    assert @user.get_the_longest_black_stripe_last_full_month == 3
  end

  test "get_the_longest_white_stripe_last_full_month returns the correct length" do
    assert @user.get_the_white_black_stripe_last_full_month == 3
  end
end
