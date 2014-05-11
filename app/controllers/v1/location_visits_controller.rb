class V1::LocationVisitsController < V1::ApiController

  def create
    @location_visit = LocationVisit.create location_visit_params
    if @location_visit.persisted?
      render_200
    else
      render_400(@location_visit.errors.messages) 
    end
  end

  private

    def location_visit_params
      params.permit(:location_id, :user_id, :visit_time)
    end
end
