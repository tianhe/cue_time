class V1::AuthenticationsController < V1::ApiController
  skip_before_filter :authenticate_user_from_token!

  def create
    user = User.find_by_email(authentication_params[:email])
    unless user && user.valid_password?(authentication_params[:password])
      render_401(['unauthorized access']) and return
    end

    render json: { user: { id: user.id, email: user.email, authentication_token: user.authentication_token } }
  end

private

  def authentication_params
    params.require(:user).permit(:email, :password)
  end
end