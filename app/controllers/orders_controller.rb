class OrdersController < ApplicationController
	def create
		# user = User.new(user_params)
		user = current_user
		order = user.build_order(state: "pending")

		# 購物車轉訂單
	    current_cart.items.each do |item|
	    	order.order_items.build(product: item.product, quantity: item.quantity)
	    end

	    if user.save
			result = Braintree::Transaction.sale(
	          amount: current_cart.total_price,
	          payment_method_nonce: params[:payment_method_nonce]
	        )

    		redirect_to products_path, notice: "Success!!"
	    else
    		redirect_to products_path, notice: "ERROR"
	    end

	    # 清空購物車
	    #session[:cart111] = nil
	end

	private
	def user_params
		params.require(:user).permit(:name, :tel, :address)
	end
end
