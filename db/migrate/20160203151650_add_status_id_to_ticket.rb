class AddStatusIdToTicket < ActiveRecord::Migration
  def change
  	 add_column :tickets, :status_id , :integer, :references => "status"
  end
end
