ActiveAdmin.register User do
  permit_params :name, :work_phone, :app_admin, :email, :password, :password_confirmation, :level_authority, :admin_level_authority

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :app_admin
    column :level_authority
    column :admin_level_authority
    column :work_phone
    actions
  end

  filter :name
  filter :email
  filter :work_phone

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :email
      f.input :work_phone

      f.input :level_authority
      f.input :admin_level_authority
      f.input :app_admin

      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
