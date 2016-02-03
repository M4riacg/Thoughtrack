class HomeController < ApplicationController
  def index
  	if !current_user 
  		redirect_to new_user_session_path	
  	end
  end

  def show
  	@closedTickets  = Ticket.where("status_id = ?", 3).order('updated_at DESC')
  end

  private
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

    def sort_column
      Ticket.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end
end
