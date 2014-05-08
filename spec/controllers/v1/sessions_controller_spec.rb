require 'spec_helper'

describe V1::SessionsController do
  render_views

  let(:user) { create(:user, password: 'hello123', password_confirmation: 'hello123') }
  
  describe "POST 'create'" do
    it 'creates a session if the email and password is valid' do
      post :create, email: user.email, password: 'hello123'
      json = JSON.parse(response.body)
      json.should == { authentication_token: user.authentication_token }.with_indifferent_access
    end

    it 'returns 401 if the password is invalid' do
      post :create, email: user.email, password: 'hello'
      json = JSON.parse(response.body)
      json.should == { status: 401, error: 'unauthorized access' }.with_indifferent_access
    end

    it 'returns 401 if the email or password isnt present' do
      post :create, password: 'hello123'
      json = JSON.parse(response.body)
      json.should == { status: 401, error: 'unauthorized access' }.with_indifferent_access
    end
  end
end