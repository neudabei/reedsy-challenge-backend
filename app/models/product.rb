class Product < ApplicationRecord
  enum :code, mug: 'mug', tshirt: 'tshirt', hoodie: 'hoodie'

  has_many :checkouts
  has_many :baskets, through: :checkouts

  validates_uniqueness_of :code
  validates_numericality_of :price, greater_than_or_equal_to: 0

  scope :price_for_all_mugs, -> { mug.sum(:price) }
  scope :price_for_all_tshirts, -> { tshirt.sum(:price) }
  scope :price_for_all_hoodies, -> { hoodie.sum(:price) }
end
