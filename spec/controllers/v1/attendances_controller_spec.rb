require 'spec_helper'

describe V1::AttendancesController do
  render_views

  let!(:user) { create(:user) }
  let!(:game) { create(:game) }

  describe "POST 'create'" do    
    it "returns http success if parameters are valid" do
      expect {
        post :create, { user_id: user.id, game_id: game.id }
        response.should be_success
      }.to change(Attendance, :count).by(1)            
    end

    it "returns 400 if the parameters are invalid" do
      expect {
        post :create, { user_id: 0, game_id: 0 }
        response.should be_400
      }.to change(Attendance, :count).by(0)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, { id: 1 }
      response.should be_success
    end

    it "returns 400 if the id doesnt exist" do
      get :show, { id: 0 }
      response.should be_400
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      put :update, { id: 1 }
      response.should be_success
    end

    it "returns 400 if the id doesnt exist" do
      put :update, { id: 0 }
      response.should be_400
    end    
  end

end
