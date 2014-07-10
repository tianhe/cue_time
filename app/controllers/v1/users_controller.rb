class V1::UsersController < V1::ApiController    
  skip_before_filter :authenticate_user_from_token!, only: :create
  before_filter :preprocess_params, only: [:create, :update]

  def create
    @user = User.create user_params
    if @user.persisted?
      render json: { user: { id: @user.id, email: @user.email, authentication_token: @user.authentication_token } }
    else
      render_400(@user.errors.full_messages)
    end    
  end

  def show
  end

  def update
    @success = @user.update(user_params)
    @success ? render_200 : render_400(['save failed']) 
  end

  private
    def preprocess_params
      params[:user][:gender].downcase! if params[:user][:gender]
      params[:user][:drinking_habit].downcase! if params[:user][:drinking_habit]    
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :gender, :birthdate, :drinking_habit)
    end

    def find_record
      begin 
        @user = User.find(params[:id])
      rescue
        render_400(['record not found'])
      end
    end
end
