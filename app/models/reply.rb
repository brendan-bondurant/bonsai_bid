class Reply < ApplicationRecord
  belongs_to :feedback

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  validates :content, presence: true

end
