class V1::SessionsController < V1::ApiController
  skip_before_filter :authenticate_user_from_token!

  def create
    user = User.find_by_email(session_params[:email])
    unless user && user.valid_password?(session_params[:password])
      render_401('unauthorized access') and return
    end

    render json: { authentication_token: user.authentication_token }
  end

private

  def session_params
    params.permit(:email, :password)
  end
end