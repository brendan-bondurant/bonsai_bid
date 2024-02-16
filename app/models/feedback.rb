class Feedback < ApplicationRecord
  belongs_to :item
  belongs_to :from_user
  belongs_to :to_user
end
