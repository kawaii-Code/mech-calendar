require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      id: 1,
      email_address: "adam@example.com",
      password: "password",
    )

    assert @user.valid?
    @user.save

    (0..4).each do |i|
      day = Day.new(user_id: 1, date: Date.today - i, rating: "bad")
      assert day.valid?
      day.save
    end

    (0..2).each do |i|
      day = Day.new(user_id: 1, date: Date.today - 5 - i, rating: "good")
      assert day.valid?
      day.save
    end

    (0..2).each do |i|
      day = Day.new(user_id: 1, date: Date.today - 8 - i, rating: "bad")
      assert day.valid?
      day.save
    end

    (0..2).each do |i|
      (0..2).each do |j|
        rating = (i % 2 == 0) ? "bad" : "good"
        day = Day.new(user_id: 1, date: Date.today - 40 - 3 * i - j, rating: rating)
        assert day.valid?
        day.save
      end
    end
  end

  test "get_the_longest_black_stripe returns the correct length" do
    assert_equal 5, @user.get_the_longest_black_stripe
  end

  test "get_the_longest_white_stripe returns the correct length" do
    assert_equal 3, @user.get_the_longest_white_stripe # 😢
  end

  test "get_count_good_days returns the correct value" do
    assert_equal 3, @user.get_count_good_days
  end

  test "get_count_bad_days returns the correct value" do
    assert_equal 8, @user.get_count_bad_days # 😭
  end

  test "get_count_bad_days_last_full_month returns the correct value" do
    assert_equal 6, @user.get_count_bad_days_last_full_month
  end

  test "get_count_good_days_last_full_month returns the correct value" do
    assert_equal 3, @user.get_count_good_days_last_full_month
  end

  test "get_the_longest_black_stripe_last_full_month returns the correct length" do
    assert_equal 3, @user.get_the_longest_black_stripe_last_full_month
  end

  test "get_the_longest_white_stripe_last_full_month returns the correct length" do
    assert_equal 3, @user.get_the_longest_white_stripe_last_full_month
  end
end
