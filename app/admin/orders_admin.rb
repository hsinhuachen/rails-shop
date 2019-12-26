Trestle.resource(:orders) do
  menu do
    item :orders, icon: "fa fa-list-alt", label: "訂單"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :state, header: "訂單狀態" do |order|
      status_tag(order.state, { "paid" => :success, "pending" => :danger }[order.state] || :default)
    end
    column :id, header: "訂單編號" do |order|
      content_tag(:span, "訂單##{order.id}")
    end
    column :total_price, header: "訂單總計" do |order|
      content_tag(:span, "NT$#{order.total_price}")
    end
    column :contact, header: "帳單" do |order|
      content_tag(:span, "#{order.name}, #{order.code}#{order.city}#{order.district}#{order.addr}")
    end
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |order|
    concat content_tag(:h2, "訂單##{order.id}")
    row do
      col(xs: 3) { select  :state, ["pending","shipping","delivered","paid","returned","refunded"], { label: "訂單狀態" } }
      col(xs: 3) { datetime_field :created_at, label: "訂購日期" }
      col(xs: 6) {  }
    end

    concat content_tag(:h3, "訂購人資訊")

    row do
      col(xs: 3){ text_field :name, label: "姓名" }
      col(xs: 3){ text_field :mobile, label: "聯絡電話" }
    end
    row do
      col(xs: 3){ text_field :city, label: "城市" }
      col(xs: 3){ text_field :district, label: "地區" }
      col(xs: 6){ text_field :addr, label: "住址" }
    end

    concat(order_helper({state: 'default',heading: '訂單資訊'}) do
      table OrderItemsAdmin.table, collection: order.order_items
    end)

    sidebar do
      concat content_tag(:h3, "訂單總計")
      row do
        col(xs: 6){ text_field :product_price, label: "商品金額" }
        col(xs: 6){ text_field :shipping, label: "運費" }
      end
      text_field :total_price, label: "總金額"
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:order).permit(:name, ...)
  # end
end
