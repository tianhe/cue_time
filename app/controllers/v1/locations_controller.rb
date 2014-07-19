class V1::LocationsController < V1::ApiController
  before_filter :find_record, only: [:show, :update]

  def create
    @location = Location.create location_params
    if @location.persisted?
      render_200
    else
      render_400(@location.errors.messages) 
    end
  end

  def show    
  end

  def update
    @success = @location.update(location_params)
    @success ? render_200 : render_400('save failed') 
  end

private

  def location_params
    params.permit(:name, :address, :city, :state, :zipcode)
  end

  def find_record
    begin 
      @location = Location.find(params[:id])
    rescue
      render_400('record not found')
    end
  end
end
