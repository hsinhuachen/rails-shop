Trestle.resource(:order_items) do
	menu do
	    item :order_items, icon: "fa fa-list-alt", label: "訂單資訊"
	end

	table do
	    column :quantity, header: "數量"
    	column :product, header: "商品名稱"
	    actions
	 end
end