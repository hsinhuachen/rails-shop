class ProductsController < ApplicationController
  	before_action :set_product, only: [:show, :edit, :update, :destroy]

  	add_breadcrumb "線上購買", :products_path

	def index
		if params[:id]
			@products = Product.where(category_id: params[:id], publish: true)
		else
			@products = Product.where(publish: true)
		end
		@categories = Category.all
	end

	def show
		product = Product.find_by(id: params[:id],publish: true)
		add_breadcrumb product.title, product_path(params[:id])
	end

	def add

	end

	private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price)
    end
end
