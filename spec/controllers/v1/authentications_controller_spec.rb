require 'spec_helper'

describe V1::AuthenticationsController do
  render_views

  let(:user) { create(:user, password: 'hello123', password_confirmation: 'hello123') }
  
  describe "POST 'create'" do
    it 'creates a authentication if the email and password is valid' do
      post :create, user: { email: user.email, password: 'hello123' }
      json = JSON.parse(response.body)
      json.should == { user: { id: user.id, email: user.email, authentication_token: user.authentication_token } }.with_indifferent_access
    end

    it 'returns 401 if the password is invalid' do
      post :create, user: { email: user.email, password: 'hello' }
      json = JSON.parse(response.body)
      json.should == { status: 401, error: ['unauthorized access'] }.with_indifferent_access
    end

    it 'returns 401 if the email or password isnt present' do
      post :create, user: { password: 'hello123' }
      json = JSON.parse(response.body)
      json.should == { status: 401, error: ['unauthorized access'] }.with_indifferent_access
    end
  end
end