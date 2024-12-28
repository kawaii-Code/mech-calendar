require 'test_helper'

class DayTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email_address: "Test User") # Предполагается, что у вас есть модель User
    @day = Day.new(date: Date.today, rating: 'good', user: @user)
  end

  test "should be valid" do
    assert @day.valid?
  end

  test "date should be present" do
    @day.date = nil
    assert_not @day.valid?
  end

  test "rating should be present" do
    @day.rating = nil
    assert_not @day.valid?
  end

  test "rating should be good or bad" do
    @day.rating = 'good'
    assert @day.valid?
    @day.rating = 'bad'
    assert @day.valid?
    @day.rating = '12345'
    assert_not @day.valid?
    @day.rating = 'normal'
    assert_not @day.valid?
    @day.rating = 'bd'
    assert_not @day.valid?
    @day.rating = '⛅'
    assert_not @day.valid?
  end

  test "date should be unique per user" do
    @day.save
    duplicate_day = @day.dup
    assert_not duplicate_day.valid?
  end

  test "date cannot be in the future" do
    @day.date = Date.tomorrow
    assert_not @day.valid?
    assert_includes @day.errors[:date], "day cannot be in the future 😡"
  end
end
