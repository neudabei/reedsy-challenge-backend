class Product < ApplicationRecord
  enum :code, mug: 'mug', tshirt: 'tshirt', hoodie: 'hoodie'
  validates_uniqueness_of :code
  validates_numericality_of :price, greater_than_or_equal_to: 0
end
