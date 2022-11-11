class AddProducts < ActiveRecord::Migration[7.0]
  def change
    Product.create(code: 'mug', name: 'Reedsy Mug', price: 600)
    Product.create(code: 'tshirt', name: 'Reedsy T-shirt', price: 1500)
    Product.create(code: 'hoodie', name: 'Reedsy Hoodie', price: 2000)
  end
end
