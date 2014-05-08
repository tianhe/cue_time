require 'spec_helper'

describe V1::ApiController do
  let(:user) { create(:user) }
  
  describe 'authenticate_user_from_token' do
    it 'should sign in user if email and authentication is present and correct' do
      controller.params = {email: user.email, authentication_token: user.authentication_token}
      controller.authenticate_user_from_token! 
      response.code.should == "200"
    end
  end
end