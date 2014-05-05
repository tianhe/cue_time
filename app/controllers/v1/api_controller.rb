class V1::ApiController < ApplicationController
  respond_to :json

  def render_200
    render json: {status: 200}, status: 200
  end

  def render_400 error=''
    @error = error
    @status = 400
    render 'v1/error', status: @status
  end

end