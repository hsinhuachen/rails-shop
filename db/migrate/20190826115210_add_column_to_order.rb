class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :pay_status, :string, default: "none"
  	add_column :orders, :shipping_status, :string, default: "none"
  	add_column :orders, :total_price, :integer
  end
end
