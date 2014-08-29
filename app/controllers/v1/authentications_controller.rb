class V1::AuthenticationsController < V1::ApiController
  skip_before_filter :authenticate_user_from_token!

  def create
    user = if authentication_params[:fb_access_token]
      fb_authentication
    else
      user_login
    end

    return unless user

    render json: { user: { id: user.id, email: user.email, authentication_token: user.authentication_token } }
  end

private
  def fb_authentication
    begin
      fb_user = FbGraph::User.me(authentication_params[:fb_access_token]).fetch

      if authentication = Authentication.find_by(provider: 'facebook', uid: fb_user.identifier)        
        user = authentication.user
        authentication.update access_token: fb_user.access_token
      else
        user = User.create email: fb_user.email, first_name: fb_user.first_name, last_name: fb_user.last_name, gender: fb_user.gender
        user.authentications.create provider: 'facebook', uid: fb_user.identifier, access_token: fb_user.access_token
      end

      user
    rescue FbGraph::InvalidToken => e
      render_401(['unauthorized fb access']) and return
    end
  end

  def user_login
    user = User.find_by(email: authentication_params[:email])

    unless user && user.valid_password?(authentication_params[:password])
      render_401(['unauthorized access']) and return
    end

    user
  end
  
  def authentication_params
    params.require(:user).permit(:email, :password, :fb_access_token)
  end
end