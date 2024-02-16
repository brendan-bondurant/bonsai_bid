class Category < ApplicationRecord
  has_many :items
  belongs_to :parent, class_name: 'Category', optional: true
end
