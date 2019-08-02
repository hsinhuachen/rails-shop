Trestle.resource(:products) do
  scope :all, -> { Product.all }, default: true
  scope :published, -> { Product.where(publish: true) }, label: "已發佈"
  scope :unpublished, -> { Product.where(publish: false) }, label: "未發佈"

  menu do
    group :product, priority: :first do
      item :products, icon: "fa fa-shopping-bag", label: "商品列表", priority: :first
    end
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :title, header: "商品名稱"
    column :price, header: "價格"
    column :category, header: "類別"
    column :sorting, header: "排序"
    column :latest, align: :center, link: false, header: "精選商品" do |product|
      if product.latest then 
        # status_tag(icon("fa fa-check"), :success) 
        link_to(status_tag(icon("fa fa-check"), :success) , admin.path(:cancel_latest, id: product.id), method: :post, class: "action-btn")
      else 
        link_to(status_tag('none', :danger) , admin.path(:pub_latest, id: product.id), method: :post, class: "action-btn")
      end
          end
    column :published, align: :center, link: false, header: "發佈" do |product|      
      if product.publish then 
        link_to(status_tag(icon("fa fa-check"), :success) , admin.path(:cancel_status, id: product.id), method: :post, class: "action-btn")
      else 
        link_to(status_tag('none', :danger) , admin.path(:pub_status, id: product.id), method: :post, class: "action-btn")
      end
    end
    column :created_at, header: "建立時間", align: :center
    column :updated_at, header: "最後更新時間", align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |product|
    tab "basic", label: "基本資訊" do
      text_field :title
      text_field :color
      text_area :description
      text_field :price, prepend: "$", label: "價格"
      text_field :sorting, label: "排序"
      select  :category_id, Category.all, { label: "類別" }

      form_group :image, label: "產品縮圖", help: "圖片尺寸 1920x1080px" do
          concat content_tag(:div, nil, class: "previewimg", id: "thumbpreview"){ 
            concat image_tag(product.image.url, class: "thumbimg") if product.image.url
          }
          raw_file_field :image, class: "thumbimg"
      end
  
      form_group :latest, label: "精選專案" do
        content_tag :fieldset, :class => "btn-group radio" do
          if product.latest == true
            concat content_tag(:input,'', type: "radio", value: true, name: 'product[latest]', id: "product_latest_0", checked: true)
            concat content_tag(:label,"是", for: 'product_latest_0', class: 'yes')
            concat content_tag(:input,'', type: "radio", value: false, name: 'product[latest]', id: "product_latest_1")
            concat content_tag(:label,"否", for: 'product_latest_1', class: 'no')
          else
            concat content_tag(:input,'', type: "radio", value: true, name: 'product[latest]', id: "product_latest_0")
            concat content_tag(:label,"是", for: 'product_latest_0', class: 'yes')
            concat content_tag(:input,'', type: "radio", value: false, name: 'product[latest]', id: "product_latest_1", checked: true)
            concat content_tag(:label,"否", for: 'product_latest_1', class: 'no')
          end
        end
      end

      form_group :publish, label: "發佈文章" do
        content_tag :fieldset, :class => "btn-group radio" do
          if product.publish == true
            concat content_tag(:input,'', type: "radio", value: true, name: 'product[publish]', id: "product_publish_0", checked: true)
            concat content_tag(:label,"是", for: 'product_publish_0', class: 'yes')
            concat content_tag(:input,'', type: "radio", value: false, name: 'product[publish]', id: "product_publish_1")
            concat content_tag(:label,"否", for: 'product_publish_1', class: 'no')
          else
            concat content_tag(:input,'', type: "radio", value: true, name: 'product[publish]', id: "product_publish_0")
            concat content_tag(:label,"是", for: 'product_publish_0', class: 'yes')
            concat content_tag(:input,'', type: "radio", value: false, name: 'product[publish]', id: "product_publish_1", checked: true)
            concat content_tag(:label,"否", for: 'product_publish_1', class: 'no')
          end
        end
      end
    end # end tab
    
    tab "report", label: "商品情報" do
      editor     :report, label: "商品情報", height: 600
    end # end tab

    row do
      col(xs: 6) { datetime_field :updated_at }
      col(xs: 6) { datetime_field :created_at }
    end
  end

  controller do 
    def pub_latest
      missile = admin.find_instance(params)
      missile.update("latest" => true);
      flash[:message] = flash_message("latest.success", title: "#{missile.title} 已設為最新商品", message: "The %{lowercase_model_name} was successfully updated.")  
      redirect_to admin.path(:index, id: missile)
    end

    def cancel_latest
      missile = admin.find_instance(params)
      missile.update("latest" => false)
      flash[:error] = flash_message("latest.cancel", title: "#{missile.title} 已取消為最新商品", message: "The %{lowercase_model_name} was successfully updated.")  
      redirect_to admin.path(:index, id: missile)
    end

    def pub_status
      missile = admin.find_instance(params)
      missile.update("publish" => true);
      flash[:message] = flash_message("publish.success", title: "#{missile.title} 已發佈", message: "The %{lowercase_model_name} was successfully updated.")  
      redirect_to admin.path(:index, id: missile)
    end

    def cancel_status
      missile = admin.find_instance(params)
      missile.update("publish" => false)
      flash[:error] = flash_message("publish.cancel", title: "#{missile.title} 已取消發佈", message: "The %{lowercase_model_name} was successfully updated.")  
      redirect_to admin.path(:index, id: missile)
    end
  end

  routes do
    post :pub_latest, on: :member
    post :cancel_latest, on: :member
    post :pub_status, on: :member
    post :cancel_status, on: :member
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:product).permit(:name, ...)
  # end
end
