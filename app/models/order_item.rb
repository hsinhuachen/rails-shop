class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order 

  def get_product_info(product_id)
    product = Product.select("title","price").find_by(id: product_id)
  end

  def get_product_total(price,quantity)
  	price * quantity
  end
end
