Trestle.resource(:galleries) do
  menu do
    group :product do
      item :galleries, icon: "fa fa-image", label: "商品圖片"
    end
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :filename, header: false, class: "col-thumb w40" do |img|
      admin_link_to(image_tag(img.filename.url, class: "img-responsive"), img) if img.filename?
    end
    column :sorting, header: "排序"
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog: true do |gallery|
    form_group :filename, label: "圖片", help: "圖片尺寸 1920x1080px" do
        raw_file_field :image
    end
    text_field :sorting, label: "排序"
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:gallery).permit(:name, ...)
  # end
end
