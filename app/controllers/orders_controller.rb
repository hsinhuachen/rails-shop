class OrdersController < ApplicationController
	def index
		user = current_user
		@orders = user.orders
	end

	def create
		# user = User.new(user_params)
		user = current_user
		order = user.orders.build(state: "pending")

		# 購物車轉訂單
	    current_cart.items.each do |item|
	    	order.order_items.build(product: item.product, quantity: item.quantity)
	    end

	    if user.save
			result = Braintree::Transaction.sale(
	          amount: current_cart.total_price,
	          payment_method_nonce: params[:payment_method_nonce]
	        )

			session[:cart1111] = nil
    		redirect_to products_path, notice: "Success!!"
	    else
    		redirect_to products_path, notice: "ERROR"
	    end
	end

	private
	def user_params
		params.require(:user).permit(:name, :tel, :address)
	end
end
