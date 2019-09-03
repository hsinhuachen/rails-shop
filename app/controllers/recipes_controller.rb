class RecipesController < ApplicationController
  	add_breadcrumb "食譜", :recipes_path

	def index
		if params[:id]
			# @posts = Recipe.tag(params[:id]).where(publish: true)
			tag = Tag.find(params["id"])
			@posts = tag.recipes.where(publish: true)
		else
			@posts = Recipe.where(publish: true)
		end
		@tags = Tag.all
	end

	def show
		@post = Recipe.find(params[:id])
		
		if @post.publish == false
			redirect_to recipes_path, notice: '食譜未發佈'
		end

		add_breadcrumb @post.title, recipe_path(params[:id])
	end
end
