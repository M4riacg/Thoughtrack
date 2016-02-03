ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ link_to("home", home_index_path) }
end
