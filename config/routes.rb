Rails.application.routes.draw do
  	devise_for :users
	root 'welcome#index'

	resources :products, only: [:index, :show]
  	get "/products/category/:id", to: "products#index", :as => :category
  	get "/about", to: "about#index"

	resource  :cart, only: [:show, :destroy] do
	  	collection do
	  		put :add, path: "add/:id"
	  		put :remove, path: "remove/:id"
	  		put :increase, path: "increase/:id"
	  		put :reduce, path: "reduce/:id"
	  		get :checkout
	  	end
	end

	resources :users, only: [:show]

	# resources :categories

	# end
end
