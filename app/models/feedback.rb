class Feedback < ApplicationRecord
  belongs_to :item
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  validates :feedback_time, presence: true
end
