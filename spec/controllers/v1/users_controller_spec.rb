require 'spec_helper'

describe V1::UsersController do
  render_views

  let(:user) { create(:user) }

  describe "POST 'create'" do
    it "returns http success if parameters are valid" do
      expect {
        post :create, user: { email: 'joe@schmoe.com', password: 'password', password_confirmation: 'password', name: 'Joe Schmoe', gender: 'male', birthdate: '2014-01-01', drinking_habit: 'social' }
        response.should be_success
      }.to change{ User.count }.by(1)

      User.first.email.should == 'joe@schmoe.com'
      User.first.name.should == 'Joe Schmoe'
      User.first.gender.should == 'male'
      User.first.birthdate.should == Date.parse('2014-01-01')
      User.first.drinking_habit.should == 'social'
      User.first.authentication_token.should_not == nil      

      json = JSON.parse(response.body)
      json.should == { user: { id: User.first.id, email: User.first.email, authentication_token: User.first.authentication_token }}.with_indifferent_access
    end

    it "returns 400 if the parameters are missing" do
      expect {
        post :create, user: { email: 'joe@schmoe.com' }
        response.code.should == '400'
      }.to_not change{ User.count }
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: user.id, email: user.email, authentication_token: user.authentication_token
      json = JSON.parse(response.body)
      json.should == { id: user.id, email: user.email, name: user.name, gender: user.gender, birthdate: user.birthdate.to_s, drinking_habit: user.drinking_habit }.with_indifferent_access
    end

    it "returns 400 if the id doesnt exist" do
      get :show, id: 0, authentication_token: user.authentication_token
      response.code.should == '400'
    end
  end

  describe "PATCH 'update'" do
    it "returns http success" do
      put :update, id: user.id, user: { gender: 'female' }, email: user.email, authentication_token: user.authentication_token 
      response.should be_success

      User.first.gender.should == 'female'
    end

    it "returns 400 if the id doesnt exist" do
      put :update, id: 0, user: { name: 'Jill' }, email: user.email, authentication_token: user.authentication_token
      response.code.should == '400'
    end    
  end
end
