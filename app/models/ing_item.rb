class IngItem
	attr_reader :ing_id

	def initialize(ing_id)
		@ing_id = ing_id
	end

	def ingItem
		Ingredient.find_by(id: ing_id)
	end
end