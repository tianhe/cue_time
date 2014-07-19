require 'spec_helper'

describe User do
  it { should have_one(:player_profile) }

  it { should have_many(:user_activities) }
  it { should have_many(:activities).through(:user_activities) }

  it { should have_many(:organized_games) }
  it { should have_many(:attendances) }
  it { should have_many(:attending_games) }

  it { should have_many(:location_visits) }
  it { should have_many(:mayorships) }

  it 'should set an authentication token' do
    @user = create(:user)
    @user.authentication_token.should_not == nil
  end
end
