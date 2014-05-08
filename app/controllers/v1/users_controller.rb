class V1::UsersController < V1::ApiController    
  skip_before_filter :authenticate_user_from_token!, only: :create

  def create
    @user = User.create user_params
    if @user.persisted?
      render json: { authentication_token: @user.authentication_token }
    else
      render_400(@user.errors.messages) 
    end    
  end

  def show
  end

  def update
    @success = @user.update(user_params)
    @success ? render_200 : render_400('save failed') 
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation, :gender, :birthdate, :drinking_habit)
    end

    def find_record
      begin 
        @user = User.find(params[:id])
      rescue
        render_400('record not found')
      end
    end
end
