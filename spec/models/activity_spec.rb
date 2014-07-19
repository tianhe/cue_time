require 'spec_helper'

describe Activity do
  it { should have_many(:user_activities) }
  it { should have_many(:users).through(:user_activities) }

  it { should validate_presence_of(:name) }
end
