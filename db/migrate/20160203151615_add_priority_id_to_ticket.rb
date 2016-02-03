class AddPriorityIdToTicket < ActiveRecord::Migration
  def change
  	add_column :tickets, :priority_id , :integer, :references => "priority"
  end
end