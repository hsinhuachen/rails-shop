class ApplicationController < ActionController::Base
	before_action :init_cart
	before_action :configure_permitted_parameters, if: :devise_controller?

	include CartsHelper
	add_breadcrumb "首頁", :root_path

	protected

	def configure_permitted_parameters
	    #註冊頁面
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :tel, :mobile, :gender, :code, :city, :district, :addr, :year, :month, :day])


	    #修改註冊資料
	    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :tel, :mobile, :gender, :code, :city, :district, :addr, :year, :month, :day])
	end

	# def after_sign_in_path_for(resource)
	# 	root_path
	# end

	private
	def init_cart
		@cart = Cart.from_hash(session[:cart1111])
	end
end
