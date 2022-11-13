class CreateCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :baskets, table_name: :checkouts do |t|
      t.index :product_id
      t.index :basket_id
    end
  end
end
