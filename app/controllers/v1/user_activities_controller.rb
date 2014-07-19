class V1::UserActivitiesController < V1::ApiController

  def create
    @user_activity = @user.user_activities.create user_activity_params
    if @user_activity.persisted?
      render_200
    else
      render_400(@user_activity.errors.messages) 
    end
  end

  def index
    @user_activities = @user.user_activities
  end

  def destroy
    if @user.user_activities.find_by(activity_id: user_activity_params[:activity_id]).try(:destroy)
      render_200
    else
      render_400(['destroy failed'])
    end
  end

private

  def user_activity_params
    params.permit(:activity_id)
  end
end
