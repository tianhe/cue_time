class V1::AttendancesController < V1::ApiController
  before_filter :find_record, only: [:show, :update]

  def create
    @attendance = Attendance.create attendance_params
    if @attendance.persisted?
      render_200
    else
      render_400(@attendance.errors.messages) 
    end
  end

  def show    
  end

  def update
    @success = @attendance.update(attendance_params)
    @success ? render_200 : render_400('save failed') 
  end

  def destroy
    @success = @attendance.destroy
    @success ? render_200 : render_400('destroy failed') 
  end

  private

    def attendance_params
      params.permit(:game_id, :user_id, :status)
    end

    def find_record
      begin 
        @attendance = Attendance.find(params[:id])
      rescue
        render_400('record not found')
      end
    end
end
