class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :days

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def self.current
    User.find(Current.session.user_id)
  end

  def did_not_rate_this_day
    days.where("date = ?", Date.today).count == 0
  end

  def get_count_good_days
    days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month).where("rating = ?", "good").count
  end

  def get_count_bad_days
    days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month).where("rating = ?", "bad").count
  end

  def get_count_good_days_last_full_month
    if Date.today.month == 1
      days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year - 1).where("cast(strftime('%m',date) as INT) = ?", 12).where("rating = ?", "good").count
    else
      days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month - 1).where("rating = ?", "good").count
    end
  end

  def get_count_bad_days_last_full_month
    if Date.today.month == 1
      days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year - 1).where("cast(strftime('%m',date) as INT) = ?", 12).where("rating = ?", "good").count
    else
      days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month - 1).where("rating = ?", "good").count
    end
  end

  def get_the_longest_white_stripe
    good_days = days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month).where("rating = ?", "good").order(date: "desc")
    if good_days.size == 0
      return 0
    end

    max_stripe = 1
    curr_stripe = 1
    last_date = good_days[0].date
    good_days.each do |d|
      if (last_date.day - d.date.day) == 1
        curr_stripe +=1
      else
        if curr_stripe > max_stripe
          max_stripe = curr_stripe
        end
        curr_stripe = 1
      end
      last_date = d.date
    end
    if curr_stripe > max_stripe
      max_stripe = curr_stripe
    end
    max_stripe
  end

  def get_the_longest_black_stripe
    bad_days = days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month).where("rating = ?", "bad").order(date: "desc")
    if bad_days.size == 0
      return 0
    end

    max_stripe = 1
    curr_stripe = 1
    last_date = bad_days[0].date
    bad_days.each do |d|
      if (last_date.day - d.date.day) == 1
        curr_stripe +=1
      else
        if curr_stripe > max_stripe
          max_stripe = curr_stripe
        end
        curr_stripe = 1
      end
      last_date = d.date
    end
    if curr_stripe > max_stripe
      max_stripe = curr_stripe
    end
    max_stripe
  end

  def get_the_longest_white_stripe_last_full_month
    if Date.today.month == 1
      good_days = days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year - 1).where("cast(strftime('%m',date) as INT) = ?", 12).where("rating = ?", "good").order(date: "desc")
    else
      good_days = days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month - 1).where("rating = ?", "good").order(date: "desc")
    end

    if good_days.size == 0
      return 0
    end

    max_stripe = 1
    curr_stripe = 1
    last_date = good_days[0].date
    good_days.each do |d|
      if (last_date.day - d.date.day) == 1
        curr_stripe +=1
      else
        if curr_stripe > max_stripe
          max_stripe = curr_stripe
        end
        curr_stripe = 1
      end
      last_date = d.date
    end
    if curr_stripe > max_stripe
      max_stripe = curr_stripe
    end
    max_stripe
  end

  def get_the_longest_black_stripe_last_full_month
    if Date.today.month == 1
      bad_days = days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year - 1).where("cast(strftime('%m',date) as INT) = ?", 12).where("rating = ?", "bad").order(date: "desc")
    else
      bad_days = days.where("cast(strftime('%Y',date) as INT) = ?", Date.today.year).where("cast(strftime('%m',date) as INT) = ?", Date.today.month - 1).where("rating = ?", "bad").order(date: "desc")
    end

    if bad_days.size == 0
      return 0
    end

    max_stripe = 1
    curr_stripe = 1
    last_date = bad_days.date
    bad_days.each do |d|
      if (last_date.day - d.date.day) == 1
        curr_stripe +=1
      else
        if curr_stripe > max_stripe
          max_stripe = curr_stripe
        end
        curr_stripe = 1
      end
      last_date = d.date
    end
    if curr_stripe > max_stripe
      max_stripe = curr_stripe
    end
    max_stripe
  end
end
