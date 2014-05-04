require 'spec_helper'

describe User do
  it { should have_one(:player_profile) }
  it { should have_many(:location_visits) }
  it { should have_many(:mayorships) }
  it { should have_many(:organized_games) }
  it { should have_many(:attending_games) }

  it { should validate_presence_of(:name) }
end
