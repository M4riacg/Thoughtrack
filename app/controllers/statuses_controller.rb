class StatusesController < InheritedResources::Base

  private

    def status_params
      params.require(:status).permit(:name)
    end
end

