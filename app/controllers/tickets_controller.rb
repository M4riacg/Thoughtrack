class TicketsController < ApplicationController
  before_action :set_ticket, except: [:index, :new, :create, :showFinalizedTickets]
  helper_method :sort_column, :sort_direction

  # GET /tickets
  # GET /tickets.json
  def index
    @priority = Priority.all
    if params[:search]
      @tickets = Ticket.search(params[:search]).order("created_at DESC")
    else
      if(current_user.level_authority < 2)
        @tickets = Ticket.where("status_id != ? AND (user_id = ? OR tecnic_id = ?)", 3,current_user.id,current_user).order(sort_column + ' ' + sort_direction)
      else
        @tickets = Ticket.all
      end
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @tecnic = User.find(@ticket.tecnic_id)
    @priority = Priority.find(@ticket.priority_id)
    @status = Status.find(@ticket.status_id)
    @comment = Comment.new
    puts "tickeeeet"
    puts @ticket.level
    @u = User.where(:level_authority => 3).pluck(:id).first


    puts "usuuuuu"
    puts @u
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create

    @ticket = current_user.tickets.new(ticket_params)
    @ticket.status_id = 1;
    if(current_user.level_authority < 2)
      @ticket.priority_id = 5;
      @ticket.tecnic_id = User.where(level_authority: 2, admin_level_authority: true).pluck(:id).first
      @ticket.level = 2;
    else
      @ticket.level = User.find(@ticket.tecnic_id).level_authority;
    end

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def proceso
    @ticket.update_attribute(:status_id, 2) 
    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
    end
  end

  def finalized
    @ticket.update_attribute(:status_id, 3) 
    respond_to do |format|
      format.html { redirect_to tickets_path, notice: 'Ticket was successfully updated.' }
    end
  end

  def morePrio
          if @ticket.priority_id > 1
    @ticket.update_attribute(:priority_id, @ticket.priority_id-1) 
    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
    end
    else
    respond_to do |format|
      format.html { redirect_to @ticket, alert: 'There is no higher priority.' }
    end
    end
  end

    def lessPrio
      if @ticket.priority_id < 5
    @ticket.update_attribute(:priority_id, @ticket.priority_id+1) 
    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
    end
    else
    respond_to do |format|
      format.html { redirect_to @ticket, alert: 'There is no lower priority.' }
    end
    end
  end

  def upgrade
    if( @ticket.level > 1 ||  @ticket.level < 3)
      next_admin = User.where(level_authority: @ticket.level+1, admin_level_authority: true).pluck(:id).first
      if ( next_admin.nil? )
        respond_to do |format|
        format.html { redirect_to @ticket, alert: 'There is impossible upgrade.' } 
        end
      else
        @ticket.update_attribute(:tecnic_id, User.where(level_authority: @ticket.level+1, admin_level_authority: true).pluck(:id).first)
        @ticket.update_attribute(:level, @ticket.level+1)

        respond_to do |format|
          format.html { redirect_to @ticket, notice: 'Ticket was successfully upgrade.' }
        end
    end
    else
    respond_to do |format|
      format.html { redirect_to @ticket, alert: 'There is impossible upgrade.' }
    end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:user_id, :title, :content, :tecnic_id, :priority_id, :status_id)
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

    def sort_column
      Ticket.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end
end
