class CreateBasket < ActiveRecord::Migration[7.0]
  def change
    create_table :baskets do |t|
      t.integer :checkout_price
      t.timestamps
    end
  end
end
