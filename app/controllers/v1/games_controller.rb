class V1::GamesController < V1::ApiController
  before_filter :preprocess_params, only: [:create, :update]

  def create
    @game = Game.create game_params
    if @game.persisted?
      render_200
    else
      render_400(@game.errors.full_messages)
    end
  end

  def show
  end

  def index
  end

  def update
    @success = @game.update(game_params)
    @success ? render_200 : render_400(['save failed']) 
  end

  private
    def preprocess_params
      params[:game][:competitiveness].downcase! if params[:game][:competitiveness]
      params[:game][:experience_level].downcase! if params[:game][:experience_level]

      if params[:game][:location]
        params[:game][:location_id] = Location.where(name: params[:game][:location]).first_or_create.id
        params[:game].delete(:location)
      end

      params[:game][:organizer_id] = @user.id
    end

    def game_params
      params.require(:game).permit(:organizer_id, :location_id, :start_time, :end_time, :min_attendance, :max_attendance, :min_age, :max_age, :gender_requirement, :drinks_requirement, :experience_level, :competitiveness, :status)
    end

    def find_record
      begin 
        @game = Game.find(params[:id])
      rescue
        render_400('record not found')
      end
    end
end
