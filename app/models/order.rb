class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  store :contact, accessors: [ :name, :mobile, :code, :city, :district, :addr ], coder: JSON

  include AASM

  aasm column: :state do
	  state :pending, initial: true
      state :paid, :shipping, :delivered, :returned, :refunded

      event :pay do
        transitions from: :pending, to: :paid
      end

      event :ship do
        transitions from: :paid, to: :shipping
      end

      event :delivering do
        transitions from: :shipping, to: :delivered
      end

      event :return do
        transitions from: [:delivered, :shipping], to: :returned
      end

      event :refund do
        transitions from: [:paid, :returned], to: :refunded
      end
	end

  def substr(str)
    if str.present?
      replace = "*"
      last = replace
      len = str.length - 3

      for i in 1..len do
        last += replace
      end

      newstr = str[1..1] + last

      newstr.prepend replace
    end
  end
end
