class CartsController < ApplicationController
  	add_breadcrumb "購物車", :cart_path

	def show
		@carts = current_cart.items
	end

	def add
		product = Product.find_by(id: params[:id])

		# 如果商品存在
		if product.present?
			current_cart.add_item(product.id,params[:quantity].to_i)
			# current_cart.add_item(product.id)

			session[:cart1111] = current_cart.serialize
			# redirect_to products_path, notice: '已加入購物車'
			redirect_back fallback_location: root_path, notice: '已加入購物車'
		else
			redirect_to products_path, notice: '查無此商品'
		end
	end

	def remove
		product = Product.find_by(id: params[:id])

		current_cart.remove_item(product.id)
		session[:cart1111] = current_cart.serialize

		redirect_to cart_path
	end

	def increase
		product = Product.find_by(id: params[:id])

		# 如果商品存在
		if product.present?
			current_cart.add_item(product.id)

			session[:cart1111] = current_cart.serialize
			redirect_to cart_path
		else
			redirect_to cart_path
		end
	end

	def reduce
		product = Product.find_by(id: params[:id])

		current_cart.remove_quantity(product.id)
		session[:cart1111] = current_cart.serialize

		redirect_to cart_path
	end

	def destroy
		session[:cart1111] = nil
		redirect_to cart_path, notice: '購物車已清空'
	end

	def checkout
		@user = current_user
		@client_token = Braintree::ClientToken.generate
	end
end
