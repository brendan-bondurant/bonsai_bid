class Item < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :category
  has_one :auction, dependent: :destroy
  accepts_nested_attributes_for :auction

  validates :name, presence: true
  validates :description, presence: true
  
  def category_name
    category = Category.find_by(id: category_id)
    if category
      category.name
    else
      'no category assigned'
    end
  end
end
