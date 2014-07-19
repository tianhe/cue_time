class V1::ActivitiesController < V1::ApiController

  def create
    @activity = Activity.create activity_params
    if @activity.persisted?
      render_200
    else
      render_400(@activity.errors.messages) 
    end
  end

  def index
    @activities = Activity.all
  end

private

  def activity_params
    params.permit(:name)
  end
end
