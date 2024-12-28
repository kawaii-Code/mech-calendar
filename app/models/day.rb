class Day < ApplicationRecord
  belongs_to :user
  validates :date, presence: true, uniqueness: { scope: :user }
  validates :rating, presence: true, inclusion: { in: %w[good bad] }
  validate :date_cannot_be_in_the_future

  private

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "day cannot be in the future 😡")
    end
  end
end
