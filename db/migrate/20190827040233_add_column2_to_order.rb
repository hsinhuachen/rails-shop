class AddColumn2ToOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :product_price, :integer
  	add_column :orders, :shipping, :integer
  	add_column :orders, :contact, :text
  	remove_column :orders, :order_id
  end
end
