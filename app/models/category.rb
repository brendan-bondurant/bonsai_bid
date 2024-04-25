class Category < ApplicationRecord
  has_many :items
  belongs_to :parent, class_name: 'Category', optional: true
  validates :name, presence: true
  # validates :description, presence: true
end
