require 'spec_helper'

describe V1::LocationVisitsController do
  render_views

  let(:user) { create(:user) }
  let(:location) { create(:location) }

  describe "POST 'create'" do
    it "returns http success if parameters are valid" do
      visit_time = Time.zone.now.to_s
      expect {

        post :create, user_id: user.id, location_id: location.id, visit_time: visit_time, email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ LocationVisit.count }.by(1)

      location_visit = LocationVisit.first
      location_visit.user_id.should == user.id
      location_visit.location_id.should == location.id
      location_visit.visit_time.should == visit_time
    end

    it "returns 400 if the parameters are invalid" do
      expect {
        post :create, user_id: 0, location_id: location.id, email: user.email, authentication_token: user.authentication_token
        response.code.should == '400'
      }.to_not change{ LocationVisit.count }
    end
  end

  describe "GET 'index'" do
    pending "returns http success" do

    end
  end
end
