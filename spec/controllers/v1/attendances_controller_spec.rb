require 'spec_helper'

describe V1::AttendancesController do
  render_views

  let(:user) { create(:user) }
  let(:game) { create(:game) }
  let(:attendance) { create(:attendance) }

  describe "GET 'index'" do
    it "returns users attendances along with game details" do
      get :index, email: attendance.user.email, authentication_token: attendance.user.authentication_token
      response.should be_success

      json = JSON.parse(response.body)
      expect(json[0]).to eq({ id: attendance.id, game_id: attendance.game_id, user_id: attendance.user_id, status: attendance.status, 
        game: { 
          id: attendance.game.id, 
          title: attendance.game.title, 
          size: attendance.game.size, 
          experience_level: attendance.game.experience_level, 
          min_age: attendance.game.min_age, max_age: attendance.game.max_age, 
          gender_requirement: attendance.game.gender_requirement, drinks_requirement: attendance.game.drinks_requirement, 
          competitiveness: attendance.game.competitiveness, 
          status: attendance.game.status, 
          neighborhood: attendance.game.location.neighborhood, 
          organizer_name: attendance.game.organizer.name, 
          activity_name: attendance.game.activity.name, 
          start_time: attendance.game.start_time.to_s, end_time: attendance.game.end_time.to_s,
          attendances: [{
            id: User.find(attendance.game.organizer_id).attendances.first.id,
            game_id: attendance.game_id,
            user_id: attendance.game.organizer_id,
            status: 'confirmed'
          }, {
            id: attendance.id,
            game_id: attendance.game_id,
            user_id: attendance.user_id,
            status: attendance.status
          }

          ]
        } 
      }.with_indifferent_access)
    end
  end

  describe "POST 'create'" do
    it "returns http success if parameters are valid" do
      expect {
        post :create, user_id: user.id, game_id: game.id, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Attendance.count }.by(2)

      Attendance.where(user_id: user.id).count.should == 1
      Attendance.find_by(user_id: user.id).game_id.should == game.id
    end

    it "returns 400 if the parameters are invalid" do
      expect {
        post :create, user_id: 0, email: user.email, authentication_token: user.authentication_token
        response.code.should == '400'
      }.to_not change{ Attendance.count }
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: attendance.id, email: user.email, authentication_token: user.authentication_token
      
      json = JSON.parse(response.body)
      json.should == { id: attendance.id, game_id: attendance.game_id, user_id: attendance.user_id, status: attendance.status,
        game: { 
          id: attendance.game.id, 
          title: attendance.game.title, 
          size: attendance.game.size, 
          experience_level: attendance.game.experience_level, 
          min_age: attendance.game.min_age, max_age: attendance.game.max_age, 
          gender_requirement: attendance.game.gender_requirement, drinks_requirement: attendance.game.drinks_requirement, 
          competitiveness: attendance.game.competitiveness, 
          status: attendance.game.status, 
          neighborhood: attendance.game.location.neighborhood, 
          organizer_name: attendance.game.organizer.name, 
          activity_name: attendance.game.activity.name, 
          start_time: attendance.game.start_time.to_s, end_time: attendance.game.end_time.to_s,
          attendances: [{
            id: User.find(attendance.game.organizer_id).attendances.first.id,
            game_id: attendance.game_id,
            user_id: attendance.game.organizer_id,
            status: 'confirmed'
          },{
            id: attendance.id,
            game_id: attendance.game_id,
            user_id: attendance.user_id,
            status: attendance.status
          }]
        } 
      }.with_indifferent_access
    end

    it "returns 400 if the id doesnt exist" do
      get :show, id: 0, email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      put :update, id: attendance.id, status: 'confirmed', email: user.email, authentication_token: user.authentication_token
      response.should be_success

      Attendance.first.status.should == 'confirmed'
    end

    it "returns 400 if the id doesnt exist" do
      put :update, id: 0, status: 'confirmed', email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end    
  end

  describe "DELETE 'destroy'" do
    it "moves attendance to canceled" do
      delete :destroy, id: attendance.id, email: user.email, authentication_token: user.authentication_token
      response.should be_success

      Attendance.find(attendance.id).status.should == 'canceled'
    end

    it "returns 400 if the id doesnt exist" do
      delete :destroy, id: 0, email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end    
  end
end
