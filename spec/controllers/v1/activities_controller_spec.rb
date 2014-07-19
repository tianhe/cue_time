require 'spec_helper'

describe V1::ActivitiesController do
  render_views
  let(:user)     { create(:user) }
  let(:activity) { create(:activity) }

  describe "POST 'create'" do    
    it "returns http success if parameters are valid" do
      expect {
        post :create, name: 'Test', email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Activity.count }.by(1)

      new_activity = Activity.first
      new_activity.name.should == 'Test'
    end

    it "does returns error if activity name already exsits" do
      activity
      
      expect {
        post :create, name: activity.name, email: user.email, authentication_token: user.authentication_token
        response.code.should == '400'
      }.to change{ Activity.count }.by(0)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      activity

      get :index, email: user.email, authentication_token: user.authentication_token
      json = JSON.parse(response.body)
      json.should == [{ id: activity.id, name: activity.name }.with_indifferent_access]
    end
  end

end
