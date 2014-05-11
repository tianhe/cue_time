require 'spec_helper'

describe V1::AttendancesController do
  render_views

  let(:user) { create(:user) }
  let(:game) { create(:game) }
  let(:attendance) { create(:attendance) }

  describe "POST 'create'" do    
    it "returns http success if parameters are valid" do
      expect {
        post :create, user_id: user.id, game_id: game.id, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Attendance.count }.by(1)

      Attendance.first.user_id.should == user.id
      Attendance.first.game_id.should == game.id
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
      json.should == { id: attendance.id, game_id: attendance.game_id, user_id: attendance.user_id, status: attendance.status }.with_indifferent_access
    end

    it "returns 400 if the id doesnt exist" do
      get :show, id: 0
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
      put :update, id: 0, status: 'confirmed'
      response.code.should == '400'
    end    
  end

  describe "GET 'index'" do
    pending "returns http success" do

    end
  end
end
