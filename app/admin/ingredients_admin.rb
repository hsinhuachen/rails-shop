Trestle.resource(:ingredients) do
  menu do
    group :recipe do
      item :ingredients, icon: "fa fa-star", label: "食材"
    end
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :title, header: "食材", class: "col-xs-4"
    column :quantity, header: "數量", class: "col-xs-4"
    column :sorting, header: "排序", class: "col-xs-4"
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog: true do |ingredient|
    row do
      col(xs: 6) { text_field :title, label: "食材" }
      col(xs: 6) { text_field :quantity, label: "數量" }
    end

    if params["recipe_id"]
      hidden_field :recipe_id, value: params["recipe_id"]
    else
      # select  :recipe_id, Recipe.all, { label: "食譜" }
    end

    text_field :sorting
  end

  controller do 
    def destroy
      self.instance.destroy
      flash[:message] = flash_message("destroy1.success", title: "食材已刪除", message: "The %{lowercase_model_name} was successfully created.")   
      redirect_to edit_recipes_admin_path(1)
      # redirect_back fallback_location: root_path
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
  #   params.require(:ingredient).permit(:name, ...)
  # end
end
