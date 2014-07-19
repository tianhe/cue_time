require 'spec_helper'

describe UserActivity do
  it { should belong_to(:activity) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:activity_id) }
end
