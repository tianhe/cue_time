require 'spec_helper'

describe V1::AuthenticationsController do
  render_views

  let(:user) { create(:user, password: 'hello123', password_confirmation: 'hello123') }
  let!(:authentication) { create(:authentication) }

  describe "POST 'create'" do
    context 'email and password' do
      it 'creates an authentication_token response if the email and password is valid' do
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

    context 'fb_login' do
      it 'creates an authentication_token response + updates authentcation if the access_token is valid and user exists' do                
        fb_user = double()
        fb_user.should_receive(:identifier) { authentication.uid }
        fb_user.should_receive(:access_token) { 'newtoken' }

        FbGraph::User.stub_chain(:me, :fetch) { fb_user }

        expect{
          post :create, user: { fb_access_token: 'validtoken' }
        }.to change{ User.count }.by(0)

        json = JSON.parse(response.body)
        json.should == { user: { id: authentication.user.id, email: authentication.user.email, authentication_token: authentication.user.authentication_token } }.with_indifferent_access

      end

      it 'creates an authentication_token response + new user + new authentication if the access_token is valid and user doesnt exist' do
        fb_user = double()
        email = Faker::Internet.email
        fb_user.should_receive(:identifier).at_least(:once) { 'new_fb_id' }
        fb_user.should_receive(:access_token) { 'newtoken' }
        fb_user.should_receive(:email) { email }
        fb_user.should_receive(:gender) { 'female' }
        fb_user.should_receive(:first_name) { Faker::Name.first_name }
        fb_user.should_receive(:last_name) { Faker::Name.last_name }

        FbGraph::User.stub_chain(:me, :fetch) { fb_user }

        expect{
          post :create, user: { fb_access_token: 'validtoken' }
        }.to change{ User.count }.by(1)

        user = User.find_by(email: email)

        json = JSON.parse(response.body)
        json.should == { user: { id: user.id, email: user.email, authentication_token: user.authentication_token } }.with_indifferent_access        
      end

      it 'returns 401 if the access_token is invalid' do
        post :create, user: { fb_access_token: 'hello123' }

        json = JSON.parse(response.body)
        json.should == { status: 401, error: ['unauthorized fb access'] }.with_indifferent_access
      end
    end
  end

end