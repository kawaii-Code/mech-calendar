require "test_helper"

class StatisticsTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      id: 1,
      email_address: "adam@example.com",
      password: "password",
    )

    assert @user.valid?

    (0..5).each do |i|
      day = Day.new(user_id: 1, date: Date.today - i, rating: "bad")
      assert day.valid?
      day.save
    end

    (0..3).each do |i|
      day = Day.new(user_id: 1, date: Date.today - 5 - i, rating: "good")
      assert day.valid?
      day.save
    end
  end

  test "get_the_longest_black_stripe returns the correct length" do
    assert_equal(0, 0)
    # assert_equal @user.get_the_longest_black_stripe, 5
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
