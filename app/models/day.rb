class Day < ApplicationRecord
  belongs_to :user
  validates :date, presence: true, uniqueness: { scope: :user }
  validates :rating, presence: true, inclusion: { in: %w[good bad] }
end
