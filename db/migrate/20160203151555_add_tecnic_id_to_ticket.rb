class AddTecnicIdToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :tecnic_id , :integer, :references => "user"
  end
end
