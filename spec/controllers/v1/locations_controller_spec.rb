require 'spec_helper'

describe V1::LocationsController do
  render_views

  let(:user) { create(:user) }
  let(:game) { create(:game) }
  let(:location) { create(:location) }

  describe "POST 'create'" do    
    it "returns http success if parameters are valid" do
      expect {
        post :create, name: 'Test', address: 'Address', city: 'New York', state: 'GA', zipcode: '10022', email: user.email, authentication_token: user.authentication_token
        response.should be_success
      }.to change{ Location.count }.by(1)

      new_location = Location.first
      new_location.name.should == 'Test'
      new_location.address.should == 'Address'
      new_location.city.should == 'New York'
      new_location.state.should == 'GA'
      new_location.zipcode.should == '10022'
    end

    it "returns 400 if the parameters are invalid" do
      expect {
        post :create, user_id: 0, email: user.email, authentication_token: user.authentication_token
        response.code.should == '400'
      }.to_not change{ Location.count }
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: location.id, email: user.email, authentication_token: user.authentication_token
      json = JSON.parse(response.body)
      json.should == { id: location.id, name: location.name, mayor_id: location.mayor_id, address: location.address, city: location.city, state: location.state, zipcode: location.zipcode }.with_indifferent_access
    end

    it "returns 400 if the id doesnt exist" do
      get :show, id: 0
      response.code.should == '400'
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      put :update, id: location.id, name: 'New', email: user.email, authentication_token: user.authentication_token
      response.should be_success

      Location.first.name.should == 'New'
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
