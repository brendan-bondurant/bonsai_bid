class Feedback < ApplicationRecord
  belongs_to :item
  belongs_to :from_user, class_name: 'User'
  belongs_to :to_user, class_name: 'User'
  belongs_to :sale_transaction

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  
  def edit_by?(user)
    from_user_id == user.id
  end

  def reply_by?(user)
    to_user_id == user.id
  end
end
