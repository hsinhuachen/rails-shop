require 'rails_helper'

RSpec.describe Order, type: :model do
  	it "收貨人資訊加上***" do
  		str = "1234567"

  		order = Order.new
  		expect(order.substr(str)).to eq("*2*****")
	end
end
