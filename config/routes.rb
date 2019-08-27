Rails.application.routes.draw do
  	devise_for :users
	root 'welcome#index'

	resources :products, only: [:index, :show]
  	get "/products/category/:id", to: "products#index", :as => :category
  	get "/recipes/tag/:id", to: "recipes#index", :as => :tag
  	get "/about", to: "about#index"

	resource  :cart, only: [:show, :create, :destroy] do
	  	collection do
	  		put :add, path: "add/:id"
	  		put :remove, path: "remove/:id"
	  		put :increase, path: "increase/:id"
	  		put :reduce, path: "reduce/:id"
	  		get :checkout
	  		get :success
	  	end
	end

	resources :users, only: [:show, :edit] do
		resource  :wish, only: [:show] do
			collection do
				put :add, path: "add/:id"
	  			put :remove, path: "remove/:id"
			end
		end
	end
	resources :recipes, only: [:index, :show]
	resources :orders, only: [:index, :show, :create]

end
