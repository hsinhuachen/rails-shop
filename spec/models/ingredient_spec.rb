require 'rails_helper'

RSpec.describe Ingredient, type: :model do
	it "將食材放進要移除的陣列" do
		dlist = Ing.new
		dlist.add_remove_item 1

		expect(dlist.empty?).to be false
	end

	it "移除很多食材到陣列裡" do
		dlist = Ing.new

		dlist.add_remove_item(1)
		dlist.add_remove_item(2)

		expect(dlist.ings.length).to be 2
	end

	it "食材可以放到陣列裡，也可以再拿出來" do
		dlist = Ing.new
		i1 = Ingredient.create(title: "白胡椒粉", quantity: "100g", recipe_id: 1)
		i2 = Ingredient.create(title: "絞肉", quantity: "100g", recipe_id: 1)

		dlist.add_remove_item i1.id
        dlist.add_remove_item i2.id

        expect(dlist.ings.first.ing_id).to be i1.id 
	end

	it "可以將陣列內容轉換成 Hash，存到 Session 裡" do
		dlist = Ing.new

		dlist.add_remove_item(1)
		dlist.add_remove_item(2)

		expect(dlist.serialize).to eq session_del_hash
	end

	private
    def session_del_hash
      {
        "items" => [
          {"ing_id" => 1},
          {"ing_id" => 2}
        ]
      }
    end
end
