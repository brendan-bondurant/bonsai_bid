class Inquiry < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :seller, class_name: 'User'
  belongs_to :item

  has_many :replies, class_name: 'Inquiry', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Inquiry', optional: true

end
