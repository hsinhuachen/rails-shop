class Ing
	attr_reader :ings

	def initialize(ings = [])
    	@ings = ings
    end

	def add_remove_item(ing_id)
		ing_item = IngItem.new(ing_id)
		@ings << ing_item
	end

	def empty?
		@ings.empty?
	end

	def serialize
		all_items = ings.map { |item|
        	{ "ing_id" => item.ing_id }
      	}

      { "items" => all_items }
	end
end