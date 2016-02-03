ActiveAdmin.register Ticket do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  permit_params :title, :user_id, :content, :tecnic_id, :priority_id, :status_id, :level

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :user_id
    column :tecnic_id
    actions
  end

  filter :title
  filter :tecnic_id
  filter :user_id
  filter :tecnic_id
  filter :priority_id
  filter :status_id
  

  form do |f|
    f.inputs "Ticket Details" do
      f.input :title
      f.input :user_id
      f.input :tecnic_id
      f.input :priority_id
      f.input :status_id
      f.input :level
      f.input :content
    end
    f.actions
  end
end
