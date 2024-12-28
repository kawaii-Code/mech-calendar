class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :days

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def self.current
    User.find(Current.session.user_id)
  end
  
  def get_count_good_days
    days.where('rating = ?', "good").count
  end
end
