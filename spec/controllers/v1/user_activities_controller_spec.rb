require 'spec_helper'

describe V1::UserActivitiesController do
  render_views
  let(:user)              { create(:user) }
  let(:activity)          { create(:activity) }
  let(:user_activity)     { create(:user_activity) }

  describe "POST 'create'" do    
    it "returns http success if parameters are valid" do
      expect {
        post :create, activity_id: activity.id, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ UserActivity.count }.by(1)

      new_activity = UserActivity.first
      new_activity.user_id.should == user.id
      new_activity.activity_id.should == activity.id
    end

    it "does returns error if activity name already exsits" do
      user_activity

      expect {
        post :create, activity_id: user_activity.activity_id, email: user_activity.user.email, authentication_token: user_activity.user.authentication_token
        response.code.should == '400'
      }.to change{ UserActivity.count }.by(0)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      user_activity

      get :index, email: user_activity.user.email, authentication_token: user_activity.user.authentication_token
      json = JSON.parse(response.body)
      json.should == [{ user_id: user_activity.user_id , activity_id: user_activity.activity_id }.with_indifferent_access]
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      user_activity

      expect {
        delete :destroy, activity_id: user_activity.activity_id, email: user_activity.user.email, authentication_token: user_activity.user.authentication_token
        response.should be_success
      }.to change { UserActivity.count }.by(-1)
    end
  end
end
