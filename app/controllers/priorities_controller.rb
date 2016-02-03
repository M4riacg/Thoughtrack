class PrioritiesController  < ApplicationController
  before_action :set_priority, except: [:index, :new, :create]

  def index
    @priorities = Priority.all
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @priority.update(priority_params)
        format.html { redirect_to priorities_path, notice: 'priority was successfully updated.' }
      	format.json { head :no_content }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def priority_params
      params.require(:priority).permit(:name, :level, :color)
    end

    def set_priority
      @priority = Priority.find(params[:id])
    end
end

