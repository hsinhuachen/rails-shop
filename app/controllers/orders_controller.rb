class OrdersController < ApplicationController
	def index
		user = current_user
		@orders = user.orders
	end

	def show
		@order = Order.find_by(id: params["id"])
		@items = @order.order_items
	end

	def create
		user = current_user
		order = user.orders.build(state: "pending", pay_status: "none", shipping_status: "none", total_price: current_cart.final_price, product_price: current_cart.total_price, shipping: current_cart.shipping, name: user_params[:name], mobile: user_params[:mobile], code: user_params[:code], city: user_params[:city], district: user_params[:district], addr: user_params[:addr])

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
    		redirect_to success_cart_path
	    else
    		redirect_to products_path, notice: "ERROR"
	    end
	end

	private
	def user_params
		params.require(:user).permit(:name, :mobile, :code, :city, :district, :addr)
	end
end
